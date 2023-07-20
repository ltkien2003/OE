package com.poly.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import com.poly.app.JpaUtils;
import com.poly.model.Share;
import com.poly.model.User;
import com.poly.model.Video;

public class ShareDAO {
	private EntityManager em = JpaUtils.getEntityManager();
	@SuppressWarnings("deprecation")
	@Override
	protected void finalize() throws Throwable {
		em.close();
		super.finalize();
	}

	public Share create(String userId, String videoId, String email) {
	    try {
	        em.getTransaction().begin();
	        User user = em.find(User.class, userId);
	        Video video = em.find(Video.class, videoId);
	        Share share = new Share();
	        share.setUser(user);
	        share.setVideo(video);
	        share.setEmail(email);
	        em.persist(share);
	        em.getTransaction().commit();
	        return share;
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw new RuntimeException(e);
	    }
	}

	public Share update(Share entity) {
		try {
			em.getTransaction().begin();
			em.merge(entity);
			em.getTransaction().commit();
			return entity;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw new RuntimeException(e);
		}
	}
	public void delete(String userId, String videoId) {
	    try {
	        em.getTransaction().begin();
	        Query query = em.createQuery("DELETE FROM Share f WHERE f.user.id = :userId AND f.video.id = :videoId");
	        query.setParameter("userId", userId);
	        query.setParameter("videoId", videoId);
	        query.executeUpdate();
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw new RuntimeException(e);
	    }
	}

	public Share remove(String id) {
		try {
			em.getTransaction().begin();
			Share entity = this.findById(id);
			em.remove(entity);
			return entity;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw new RuntimeException(e);
		}
	}

	public Share findById(String id) {
		Share entity = em.find(Share.class, id);
		return entity;
	}
	public Share findByEmail(String email) {
		Share entity = em.find(Share.class, email);
		return entity;
	}

	public List<Share> findAll() {
		String jpql = "SELECT o FROM Share o";
		TypedQuery<Share> query = em.createQuery(jpql, Share.class);
		List<Share> list = query.getResultList();
		return list;
	}
}

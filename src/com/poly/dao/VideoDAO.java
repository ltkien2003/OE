package com.poly.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import com.poly.app.JpaUtils;
import com.poly.model.Video;
import com.poly.model.User;
import com.poly.model.Video;

public class VideoDAO {
	private EntityManager em = JpaUtils.getEntityManager();
	@SuppressWarnings("deprecation")
	@Override
	protected void finalize() throws Throwable {
		em.close();
		super.finalize();
	}

	public Video create(Video entity) {
		try {
			em.getTransaction().begin();
			em.persist(entity);
			em.getTransaction().commit();
			return entity;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw new RuntimeException(e);
		}
	}
	public Video update(Video entity) {
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
	        Query query = em.createQuery("DELETE FROM Video f WHERE f.user.id = :userId AND f.video.id = :videoId");
	        query.setParameter("userId", userId);
	        query.setParameter("videoId", videoId);
	        query.executeUpdate();
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw new RuntimeException(e);
	    }
	}
	

	public Video remove(String id) {
		try {
			em.getTransaction().begin();
			Video entity = em.find(Video.class, id);
			em.remove(entity);
			em.getTransaction().commit();
			return entity;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw new RuntimeException(e);
		}
	}

	public Video findById(String id) {
		Video entity = em.find(Video.class, id);
		return entity;
	}
	public Video findByEmail(String email) {
		Video entity = em.find(Video.class, email);
		return entity;
	}

	public List<Video> findAll() {
		String jpql = "SELECT o FROM Video o";
		TypedQuery<Video> query = em.createQuery(jpql, Video.class);
		List<Video> list = query.getResultList();
		return list;
	}
}

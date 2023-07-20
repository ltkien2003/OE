package com.poly.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import com.poly.app.JpaUtils;
import com.poly.model.Favorite;
import com.poly.model.User;
import com.poly.model.Video;

public class FavoriteDAO {
	private EntityManager em = JpaUtils.getEntityManager();
	@SuppressWarnings("deprecation")
	@Override
	protected void finalize() throws Throwable {
		em.close();
		super.finalize();
	}

	public Favorite create(String userId, String videoId) {
	    try {
	        em.getTransaction().begin();
	        
	        User user = em.find(User.class, userId);
	        Video video = em.find(Video.class, videoId);
	        Favorite favorite = new Favorite();
	        favorite.setUser(user);
	        favorite.setVideo(video);
	        
	        em.persist(favorite);
	        em.getTransaction().commit();
	        return favorite;
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw new RuntimeException(e);
	    }
	}

	public Favorite update(Favorite entity) {
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
	        Query query = em.createQuery("DELETE FROM Favorite f WHERE f.user.id = :userId AND f.video.id = :videoId");
	        query.setParameter("userId", userId);
	        query.setParameter("videoId", videoId);
	        query.executeUpdate();
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw new RuntimeException(e);
	    }
	}

	public Favorite remove(String id) {
		try {
			em.getTransaction().begin();
			Favorite entity = this.findById(id);
			em.remove(entity);
			return entity;
		} catch (Exception e) {
			em.getTransaction().rollback();
			throw new RuntimeException(e);
		}
	}

	public Favorite findById(String id) {
		Favorite entity = em.find(Favorite.class, id);
		return entity;
	}
	public Favorite findByEmail(String email) {
		Favorite entity = em.find(Favorite.class, email);
		return entity;
	}

	public List<Favorite> findAll() {
		String jpql = "SELECT o FROM Favorite o";
		TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
		List<Favorite> list = query.getResultList();
		return list;
	}
}

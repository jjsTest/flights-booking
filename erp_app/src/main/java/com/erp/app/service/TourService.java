package com.erp.app.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.erp.app.dao.TourDao;
import com.erp.app.dto.TourDTO;

@Service
public class TourService {

	@Autowired
	private TourDao tourDao;
	@Autowired
	private HttpServletRequest request;

	// 투어 전체 list
	public List<TourDTO> selectTourList(TourDTO tour) {
		return tourDao.selectTourList(tour);
	}

	// 투어 가능 날짜
	public List<String> selectEnableDate(TourDTO tour) {
		System.out.println("TourService#################1");
		List<TourDTO> enableDate = tourDao.selectEnableDate(tour);
		System.out.println("TourService#################2");
		List<String> list = new ArrayList<String>();

		for (TourDTO d : enableDate) {
			System.out.println("TourDTD d:"+d);
			list.add(d.getDate());
		}
		return list;
	}

	// 해당 날짜에 대한 가능 좌석
	public List<TourDTO> selectViewSeats(TourDTO tour) {
		return tourDao.selectViewSeats(tour);

	}

	// 선택좌석 이용가능한지 확인 
	public TourDTO selectSeatCheck(TourDTO tour) {
		return tourDao.selectSeatCheck(tour);

	}

	// 해당좌석 order_type 업데이트
	public void updateOrederType(TourDTO tour) {
		tourDao.updateOrederType(tour);
	}

	// 결제
	public void insertOrder(TourDTO tour) {
		tourDao.insertOrder(tour);
	}

	// 주문 확인
	public List<TourDTO> selectOwnOrder(TourDTO tour) {
		return tourDao.selectOwnOrder(tour);
	}
}

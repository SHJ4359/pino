package com.pino.domain;

public class ImageDto {
	private String carrierName;
	private String cmpName;
	
	public String getCarrierName() {
		return carrierName;
	}
	public void setCarrierName(String carrierName) {
		this.carrierName = carrierName;
	}
	public String getCmpName() {
		return cmpName;
	}
	public void setCmpName(String cmpName) {
		this.cmpName = cmpName;
	}
	
	@Override
	public String toString() {
		return "ImageDto [carrierName=" + carrierName + ", cmpName=" + cmpName + "]";
	}
}

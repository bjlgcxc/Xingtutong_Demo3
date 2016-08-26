package com.springmvc.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="ephemerisdata")
public class EphemerisData{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long ID;
	private String Satellitesystem;
    private String Satellitenumber;
    private Date Epoch;
    private Double Crs;
    private Double Deltan;
    private Double M0;
    private Double Cuc;
    private Double E;
    private Double Cus;
    private Double SqrtA;
    private Double Toe;
    private Double Cic;
    private Double Omega0;
    private Double Cis;
    private Double I0;
    private Double Crc;
    private Double Omega;
    private Double Omegadot;
    private Double Idot;
    private Double Xk;
    private Double Yk;
    private Double Zk;
    private Double xx;
    private Double yy;
    private Double bj;
    private String bw;

    public Long getID() {
		return ID;
	}
	public void setID(Long ID) {
		this.ID = ID;
	}
	public String getSatellitesystem() {
		return Satellitesystem;
	}
	public void setSatellitesystem(String satellitesystem) {
		Satellitesystem = satellitesystem;
	}
	public String getSatellitenumber() {
		return Satellitenumber;
	}
	public void setSatellitenumber(String satellitenumber) {
		Satellitenumber = satellitenumber;
	}
	public Date getEpoch() {
		return Epoch;
	}
	public void setEpoch(Date epoch) {
		Epoch = epoch;
	}
	public Double getCrs() {
		return Crs;
	}
	public void setCrs(Double crs) {
		Crs = crs;
	}
	public Double getDeltan() {
		return Deltan;
	}
	public void setDeltan(Double deltan) {
		Deltan = deltan;
	}
	public Double getM0() {
		return M0;
	}
	public void setM0(Double m0) {
		M0 = m0;
	}
	public Double getCuc() {
		return Cuc;
	}
	public void setCuc(Double cuc) {
		Cuc = cuc;
	}
	public Double getE() {
		return E;
	}
	public void setE(Double e) {
		E = e;
	}
	public Double getCus() {
		return Cus;
	}
	public void setCus(Double cus) {
		Cus = cus;
	}
	public Double getSqrtA() {
		return SqrtA;
	}
	public void setSqrtA(Double sqrtA) {
		SqrtA = sqrtA;
	}
	public Double getToe() {
		return Toe;
	}
	public void setToe(Double toe) {
		Toe = toe;
	}
	public Double getCic() {
		return Cic;
	}
	public void setCic(Double cic) {
		Cic = cic;
	}
	public Double getOmega0() {
		return Omega0;
	}
	public void setOmega0(Double omega0) {
		Omega0 = omega0;
	}
	public Double getCis() {
		return Cis;
	}
	public void setCis(Double cis) {
		Cis = cis;
	}
	public Double getI0() {
		return I0;
	}
	public void setI0(Double i0) {
		I0 = i0;
	}
	public Double getCrc() {
		return Crc;
	}
	public void setCrc(Double crc) {
		Crc = crc;
	}
	public Double getOmega() {
		return Omega;
	}
	public void setOmega(Double omega) {
		Omega = omega;
	}
	public Double getOmegadot() {
		return Omegadot;
	}
	public void setOmegadot(Double omegadot) {
		Omegadot = omegadot;
	}
	public Double getIdot() {
		return Idot;
	}
	public void setIdot(Double idot) {
		Idot = idot;
	}
	public Double getXk() {
		return Xk;
	}
	public void setXk(Double xk) {
		Xk = xk;
	}
	public Double getYk() {
		return Yk;
	}
	public void setYk(Double yk) {
		Yk = yk;
	}
	public Double getZk() {
		return Zk;
	}
	public void setZk(Double zk) {
		Zk = zk;
	}
	public Double getXx() {
		return xx;
	}
	public void setXx(Double xx) {
		this.xx = xx;
	}
	public Double getYy() {
		return yy;
	}
	public void setYy(Double yy) {
		this.yy = yy;
	}
	public Double getBj() {
		return bj;
	}
	public void setBj(Double bj) {
		this.bj = bj;
	}
	public String getBw() {
		return bw;
	}
	public void setBw(String bw) {
		this.bw = bw;
	}
}

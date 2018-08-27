package com.lxf.bean;


public class Employee {
	
	private Long associateId;
	private String birthDate;
	private String employmentDate;
	private String firstName;
	private String lastName;
	private String displayName;
	private Integer employType;
	private Integer personalStatus;
	public Long getAssociateId() {
		return associateId;
	}
	public void setAssociateId(Long associateId) {
		this.associateId = associateId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	public Integer getEmployType() {
		return employType;
	}
	public void setEmployType(Integer employType) {
		this.employType = employType;
	}
	public Integer getPersonalStatus() {
		return personalStatus;
	}
	public void setPersonalStatus(Integer personalStatus) {
		this.personalStatus = personalStatus;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getEmploymentDate() {
		return employmentDate;
	}
	public void setEmploymentDate(String employmentDate) {
		this.employmentDate = employmentDate;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
}

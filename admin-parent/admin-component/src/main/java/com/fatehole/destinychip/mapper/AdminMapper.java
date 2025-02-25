package com.fatehole.destinychip.mapper;

import java.util.List;

import com.fatehole.destinychip.entity.Admin;
import com.fatehole.destinychip.entity.AdminExample;
import org.apache.ibatis.annotations.Param;

public interface AdminMapper {
    long countByExample(AdminExample example);

    int deleteByExample(AdminExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Admin record);

    int insertSelective(Admin record);

    List<Admin> selectByExample(AdminExample example);

    Admin selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Admin record, @Param("example") AdminExample example);

    int updateByExample(@Param("record") Admin record, @Param("example") AdminExample example);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKey(Admin record);

    List<Admin> selectAdminByKeyword(String keyword);

    void deleteRelationship(Integer id);

    void insertNewRelationship(@Param("id") Integer id, @Param("roleIdList") List<Integer> roleIdList);
}
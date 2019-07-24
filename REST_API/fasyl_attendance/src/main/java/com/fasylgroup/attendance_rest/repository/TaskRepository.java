package com.fasylgroup.attendance_rest.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.fasylgroup.attendance_rest.model.Task;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

}

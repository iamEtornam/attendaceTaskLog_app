package com.fasylgroup.attendance_rest.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasylgroup.attendance_rest.model.Task;
import com.fasylgroup.attendance_rest.repository.TaskRepository;
import com.fasylgroup.attendance_rest.utils.ResourceNotFoundException;

@RestController
@RequestMapping("/api")
public class TaskController {
	 @Autowired
	    TaskRepository taskRepository;
	 
	// Create a new Task
	 @PostMapping("/tasks")
	 @PreAuthorize("hasRole('USER')")
	 public Task createTasks(@Valid @RequestBody Task task) {
	     return taskRepository.save(task);
	 }
	 
	// Get All Task
	 @GetMapping("/tasks")
	 @PreAuthorize("hasRole('USER') or hasRole('ADMIN')")
	 public List<Task> getAllTasks() {
	     return taskRepository.findAll();
	 }
	 
	// Get a Single Task
	 @GetMapping("/tasks/{id}")
	 @PreAuthorize("hasRole('USER')")
	 public Task getTaskById(@PathVariable(value = "id") Long taskId) {
	     return taskRepository.findById(taskId)
	             .orElseThrow(() -> new ResourceNotFoundException("Task", "id", taskId));
	 }
	 
	// Update a Task
	 @PutMapping("/tasks/{id}")
	 @PreAuthorize("hasRole('USER')")
	 public Task updateTask(@PathVariable(value = "id") Long taskId,
	                                         @Valid @RequestBody Task taskDetails) {

	     Task task = taskRepository.findById(taskId)
	             .orElseThrow(() -> new ResourceNotFoundException("Task", "id", taskId));

	     task.setTitle(taskDetails.getTitle());
	     task.setDescription(taskDetails.getDescription());
	     task.setStartTime(taskDetails.getStartTime());
	     task.setEndTime(taskDetails.getEndTime());
	     task.setIsCompleted(taskDetails.getIsCompleted());
	     task.setIsInProgress(taskDetails.getIsInProgress());

	     Task updatedTask = taskRepository.save(task);
	     return updatedTask;
	 }
	 
	// Delete a Task
	 @DeleteMapping("/tasks/{id}")
	 @PreAuthorize("hasRole('USER')")
	 public ResponseEntity<?> deleteTask(@PathVariable(value = "id") Long taskId) {
	     Task task = taskRepository.findById(taskId)
	             .orElseThrow(() -> new ResourceNotFoundException("Task", "id", taskId));

	     taskRepository.delete(task);

	     return ResponseEntity.ok().build();
	 }
}

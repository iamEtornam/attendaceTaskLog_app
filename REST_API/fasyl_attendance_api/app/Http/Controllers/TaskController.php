<?php

namespace App\Http\Controllers;

use App\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $task = auth()->user()->tasks;

      if(!$task){
          return response()->json([
              'success' => false,
              'message' => 'No Task found.'
          ],404);
      }
        return response()->json([
            'success' => true,
            'data' => $task
        ],200);

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'price' => 'required|integer'
        ]);

        $task = new Task();
        $task->title = $request->title;
        $task->description = $request->description;
        $task->start_time = $request->start_time;
        $task->end_time = $request->end_time;
        $task->is_completed = $request->is_completed;
        $task->is_in_progress = $request->is_in_progress;

        $save = auth()->user()->tasks()->save($task);
        if ($save)
            return response()->json([
                'success' => true,
                'data' => $task->toArray()
            ],200);
        else
            return response()->json([
                'success' => false,
                'message' => 'Task could not be added'
            ], 401);
    }

    /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function show(int $id)
    {
        $task = auth()->user()->tasks()->find($id);

        if (!$task) {
            return response()->json([
                'success' => false,
                'message' => 'Task with id ' . $id . ' not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $task->toArray()
        ], 200);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $task = auth()->user()->tasks()->find($id);

        if (!$task) {
            return response()->json([
                'success' => false,
                'message' => 'Task with id ' . $id . ' not found'
            ], 404);
        }

        $updated = $task->fill($request->all())->save();

        if ($updated)
            return response()->json([
                'success' => true,
                'data'=>$task
            ],200);
        else
            return response()->json([
                'success' => false,
                'message' => 'Task could not be updated'
            ], 401);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $task = auth()->user()->tasks()->find($id);

        if (!$task) {
            return response()->json([
                'success' => false,
                'message' => 'Task with id ' . $id . ' not found'
            ], 404);
        }

        if ($task->delete()) {
            return response()->json([
                'success' => true
            ],200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Task could not be deleted'
            ], 401);
        }
    }
}

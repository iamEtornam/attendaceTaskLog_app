<?php

namespace App\Http\Controllers;

use App\Manager;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{
    /**
     * Handles Registration Request
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function user_register(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|min:3',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
            'phone' => 'required|min:10|max:13',
            'department' => 'required',
            'photo' => 'required',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'phone' => $request->phone,
            'department' => $request->department,
            'photo' => $request->photo,
            'manager_id'=>$request->manager_id
        ]);

        if ($user) {
            return response()->json(['message' => 'user registered successfully', 'data'=>$user], 200);
        }

        return response()->json(['message' => 'Could not register user'], 401);
    }

    /**
     * Handles Login Request
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function user_login(Request $request)
    {
        $credentials = [
            'email' => $request->email,
            'password' => $request->password
        ];

        if (auth()->attempt($credentials)) {
            $token = auth()->user()->createToken('FasylAttendanceApp')->accessToken;
            return response()->json(['token' => $token, 'message' => 'login successful', 'data'=>auth()->user()], 200);
        } else {
            return response()->json(['message' => 'UnAuthorised'], 401);
        }
    }



    /**
     * Handles Manager Registration Request
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function manager_register(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|min:3',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:6',
            'department' => 'required',
            'photo' => 'required',
        ]);

        $manger = Manager::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'department' => $request->department,
            'photo' => $request->photo
        ]);

        if ($manger) {
            return response()->json([
                'message' => 'user registered successfully',
                'data'=>$manger
            ], 200);
        }

        return response()->json(['message' => 'Could not register user'], 401);
    }

    /**
     * Handles Manager Login Request
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function manager_login(Request $request)
    {
        $credentials = [
            'email' => $request->email,
            'password' => $request->password
        ];

        if (auth()->attempt($credentials)) {
            $token = auth()->user()->createToken('FasylAttendanceApp')->accessToken;
            return response()->json(['token' => $token, 'message' => 'login successful','data'=>auth()->user()], 200);
        } else {
            return response()->json(['message' => 'UnAuthorised'], 401);
        }
    }



    /**
     * Returns Authenticated User Details
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function details()
    {
        return response()->json(['data' => auth()->user()], 200);
    }


    public function getManagerUser()
    {
        $manager = auth()->user();
        $users = DB::table('users')->where('manager_id', $manager->id)->get();

        if (!$users) {
            return response()->json([
                'success' => false,
                'message' => 'No user found.'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $users->toArray()
        ], 200);

    }

    public function logout(){
        $logout = DB::table('oauth_access_tokens')
            ->where('user_id', Auth::user()->id)
            ->update([
                'revoked' => true
            ]);

        if(!$logout){
            return response()->json([
                'success' => false,
                'message' => 'Could not Logout.'
            ], 404);
        }
        return response()->json([
            'success' => true,
            'message'=>'Logout successful'
        ], 200);
    }

}

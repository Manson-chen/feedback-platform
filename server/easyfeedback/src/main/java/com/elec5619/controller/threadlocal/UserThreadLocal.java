package com.elec5619.controller.threadlocal;

import com.elec5619.domain.SimpleUser;

public class UserThreadLocal {

    private UserThreadLocal(){}

    /**
     * 保存用户对象的ThreadLocal
     */
    private static final ThreadLocal<SimpleUser> LOCAL = new ThreadLocal<>();

    /**
     * 将当前用户存放进ThreadLocal里
     */
    public static void set(SimpleUser simpleUser){
        System.out.println("Put user in ThreadLocal");
        LOCAL.set(simpleUser);
    }

    public static SimpleUser get(){
        System.out.println("Get user from ThreadLocal");
        return LOCAL.get();
    }

    public static void remove(){
        System.out.println("Remove user from ThreadLocal");
        LOCAL.remove();
    }

}

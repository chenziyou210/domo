/*
 *  Copyright (C), 2015-2021
 *  FileName: constrains_expand_widget
 *  Author: Tonight丶相拥
 *  Date: 2021/7/21
 *  Description: 
 **/

part of appcommon;


class ConstrainsExpandWidget extends ConstrainedBox {
  ConstrainsExpandWidget({required this.child}):
        super(constraints: BoxConstraints.expand());
  final Widget child;
}
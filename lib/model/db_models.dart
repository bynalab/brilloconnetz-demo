import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'db_models.g.dart';

const userTable = SqfEntityTable(
  tableName: 'users',
  primaryKeyName: 'userId',
  primaryKeyType: PrimaryKeyType.text,
  modelName: 'User',
  fields: [
    SqfEntityField('email', DbType.text, isUnique: true, maxValue: 50),
    SqfEntityField('phone', DbType.text, isUnique: true, maxValue: 15),
    SqfEntityField('interests', DbType.text),
    SqfEntityField('password', DbType.text),
    SqfEntityField('code', DbType.integer, maxValue: 5),
    SqfEntityField('isVerified', DbType.bool, defaultValue: false),
    SqfEntityField('createdAt', DbType.datetimeUtc, defaultValue: null),
    SqfEntityField('updatedAt', DbType.datetimeUtc, defaultValue: null),
  ],
);

@SqfEntityBuilder(quickManagerDbModel)
const quickManagerDbModel = SqfEntityModel(
  databaseName: 'brilloconnectz.db',
  dbVersion: 1,
  databaseTables: [userTable],
  bundledDatabasePath: null,
);

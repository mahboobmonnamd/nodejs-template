import 'reflect-metadata';
import env from 'dotenv';
import config from 'config';

env.config();
// if not need, remove it.
config.get('key');

console.log('hello world');

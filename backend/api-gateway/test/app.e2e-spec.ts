import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { App } from 'supertest/types';
import { AppModule } from './../src/app.module';

describe('API Gateway e2e', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it('/api/users/health (GET)', () => {
    return request(app.getHttpServer())
      .get('/api/users/health')
      .expect(200)
      .expect({ status: 'ok' });
  });

  it('/api/auth/register (POST)', () => {
    return request(app.getHttpServer())
      .post('/api/auth/register')
      .send({
        name: 'Test',
        email: 'test@example.com',
        password: 'secret',
        date_naissance: '1990-01-01',
        telephone: '12345678',
        address: 'Rue de Test',
        piece_identite: 'ID123',
        isVerified: false
      })
      .expect(201)   // ou 200 selon ton implémentation
      .then(res => {
        expect(res.body).toHaveProperty('message', 'Inscription réussie');
      });
  });

  afterAll(async () => {
    await app.close();
  });
});
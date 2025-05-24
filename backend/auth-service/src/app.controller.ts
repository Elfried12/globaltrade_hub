// src/app.controller.ts
import {
  Controller,
  Post,
  Body,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { AppService } from './app.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';

 @Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Post('register')
  async register(@Body() createDto: RegisterDto) {
    try {
      await this.appService.register(createDto);
      return {
        message: 'Inscription réussie. Connectez-vous.',
      };
    } catch (error) {
      throw new HttpException(
        {
          message: 'Une erreur est survenue lors de l’inscription.',
          details: error.message,
        },
        HttpStatus.BAD_REQUEST,
      );
    }
  }

  
  @Post('login')
  async login(@Body() loginDto: LoginDto) {
    try {
      const result = await this.appService.login(loginDto);
      return {
        message: 'Connexion réussie.',
        accessToken: result.accessToken,
        user: result.user,
      };
    } catch (error) {
      throw new HttpException(
        {
          message: 'Identifiants invalides.',
          details: error.message,
        },
        HttpStatus.UNAUTHORIZED,
      );
    }
  }
}

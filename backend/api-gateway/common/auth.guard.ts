import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';

@Injectable()
export class AuthGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request: Request = context.switchToHttp().getRequest();
    const token = request.headers['authorization'];

    // Exemple : vérifie simplement que le token est présent
    if (!token) return false;

    // Logique de vérification avancée peut être ajoutée ici
    return true;
  }
}

import { Injectable, CanActivate, ExecutionContext, ForbiddenException } from '@nestjs/common';

@Injectable()
export class ApiKeyGuard implements CanActivate {
  private readonly validApiKeys = ['d7e853a4-829e-4b8e-9e7d-42f2904a1c92', 'd7e853a4-829e-4b8e-9e7d-42f2904a1c93', 'random-valid-api-key'];

  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest();
    const apiKey = request.headers['api-key'];
    
    if (!this.validApiKeys.includes(apiKey)) {
      throw new ForbiddenException({
        message: "Access denied invalid API key",
        error: "Forbidden (Invalid API key)",
        statusCode: 403
      });
    }
    
    return true;
  }
}

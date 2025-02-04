import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ExchangeController } from './exchange/exchange.controller';
import { ExchangeService } from './exchange/exchange.service';

@Module({
  imports: [HttpModule],
  controllers: [ExchangeController],
  providers: [ExchangeService],
})
export class AppModule {}
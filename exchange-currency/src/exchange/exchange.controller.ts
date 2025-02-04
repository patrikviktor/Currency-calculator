import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { ExchangeService } from './exchange.service';
import { ApiKeyGuard } from './api-key.guard';

@Controller('rates')
@UseGuards(ApiKeyGuard)
export class ExchangeController {
  constructor(private exhangeService: ExchangeService) {}

  @Get()
  async getRates(@Query('currency') currency?: string | string[]): Promise<any> {
    const data = await this.exhangeService.fetchRates();

    if (currency) {
      const currencies = Array.isArray(currency) ? currency : currency.split(',');
      
      const filteredRates = data.rates.filter((r) => 
        currencies.map(c => c.toUpperCase())
          .includes(r.name.toUpperCase())
      );
      

      const filteredRate = filteredRates.reduce((acc, curr) => {
        acc[curr.name] = curr.rate;
        return acc;
      }, {});

      return {
        date: data.date,
        rate: filteredRate,
        rates: filteredRates
      };
    }

    return data;
  }
}

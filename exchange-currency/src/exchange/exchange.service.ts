import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { parseStringPromise } from 'xml2js';

export interface CurrencyRate {
  name: string;
  rate: number;
}

@Injectable()
export class ExchangeService {
readonly ECB_URL = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml';

  async fetchRates(): Promise<{ date: string; rate: Record<string, number>; rates: CurrencyRate[] }> {
    try {
      const response = await axios.get(this.ECB_URL, { responseType: 'text' });
      const xmlData = response.data;
      const jsonData = await parseStringPromise(xmlData);


      const cubeBase = jsonData['gesmes:Envelope']?.Cube?.[0]?.Cube?.[0];
      const date = cubeBase.$.time;
      const cubes = cubeBase.Cube;

      if (!cubes) {
        throw new Error('Data not found');
      }

      const rate: Record<string, number> = {};
      const rates: CurrencyRate[] = cubes.map((cube: any) => {
        const currency = cube.$.currency;
        const value = Number(cube.$.rate);
        rate[currency] = value;
        return { name: currency, rate: value };
      });

      rate['EUR'] = 1;
      rates.push({ name: 'EUR', rate: 1 });

      return { date, rate, rates };
    } catch (error) {
      throw new Error('Error during gathering or parsing data: ' + error.message);
    }
  }
}

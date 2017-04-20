import { Component, Input } from '@angular/core';
import { Hero } from './hero';

@Component({
  selector: 'hero-detail',
  templateUrl: './hero-detail.component.html',
  styleUrls: ['./app.component.css']
})
export class HeroDetailComponent {
  @Input() hero: Hero;
}


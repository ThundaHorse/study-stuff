# Services

- A class that encapsulates reusable logic
  - Can be used across different components
  - Typically used for data fetching, business logic, and other operations that need to be shared.

- The `inject()` function provides a way to access dependency injection within component constructors and class methods
  - Simplifying the dependency injection process.

## Example

- Fetching data from API and sharing it across multiple components

```javascript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject } from 'rxjs';
import { tap } from 'rxjs/operators';

// Decorator that allows it to be provided and injected as a dependency
@Injectable({
  providedIn: 'root',
})


export class DataService {
  private dataSubject = new BehaviorSubject < any > (null);

  // Naming convention which means the variable holds and Observable
  data$ = this.dataSubject.asObservable();

  constructor(private http: HttpClient) { }

  // Key concept for handling asynchronous operations
  // Represents a strea of values over time
  fetchData(): Observable<any> {
    return this.http.get('https://api.example.com/data').pipe(
      tap((data) => this.dataSubject.next(data))
    );
  }

  getData(): Observable<any> {
    return this.data$;
  }
}
```

### NgZone

- Injectable service for executing work inside or outside of the Angular zone
- The most common use of this service is to optimize performance when starting a work consisting of one or more asynchronous tasks that don't require UI updates or error handling to be handled by Angular.
  - Such tasks can be kicked off via `runOutsideAngular` and if needed, these tasks can reenter the Angular zone via `run`.

Example

```typescript
import {Component, NgZone} from '@angular/core';
import {NgIf} from '@angular/common';
@Component({
  selector: 'ng-zone-demo',
  template: `
    <h2>Demo: NgZone</h2>
    <p>Progress: {{progress}}%</p>
    <p *ngIf="progress >= 100">Done processing {{label}} of Angular zone!</p>
    <button (click)="processWithinAngularZone()">Process within Angular zone</button>
    <button (click)="processOutsideOfAngularZone()">Process outside of Angular zone</button>
  `,
})

export class NgZoneDemo {
  progress: number = 0;
  label: string;
  constructor(private _ngZone: NgZone) {}

  // Loop inside the Angular zone
  // so the UI DOES refresh after each setTimeout cycle
  processWithinAngularZone() {
    this.label = 'inside';
    this.progress = 0;
    this._increaseProgress(() => console.log('Inside Done!'));
  }

  // Loop outside of the Angular zone
  // so the UI DOES NOT refresh after each setTimeout cycle
  processOutsideOfAngularZone() {
    this.label = 'outside';
    this.progress = 0;
    this._ngZone.runOutsideAngular(() => {
      this._increaseProgress(() => {
        // reenter the Angular zone and display done
        this._ngZone.run(() => { console.log('Outside Done!'); });
      });
    });
  }

  _increaseProgress(doneCallback: () => void) {
    this.progress += 1;
    console.log(`Current progress: ${this.progress}%`);
    if (this.progress < 100) {
      window.setTimeout(() => this._increaseProgress(doneCallback), 10);
    } else {
      doneCallback();
    }
  }
}
```

### When to use `Ngzone.run()`

- `ngZone.runOutsideAngular()` - this runs the code outside the angular zone.
  - When some event is fired and it tells Angular to detect changes
  - When using `mouseUp()` or `mouseDown()` event
    - Then on every change it tells angular to detect the changes
  - When we don't want these change sto take place run-time in Angular
    - Reduces performance of the app
    - Can run it outside the Angular zone
  - Contrasted to this, if we want to get each and every update, then we can use `ngZone.run()`
    - Will run the change detection in normal
- Angular itself uses `ngZone` under the hood to detect changes
  - If coming out of Angular zone, go back by using `ngZone.run()`
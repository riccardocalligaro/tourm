<?php

namespace App\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Testing\Fluent\Concerns\Has;
use Laravel\Lumen\Auth\Authorizable;

/**
 * App\Models\Beacon
 *
 * @property string $uuid
 * @property string $name
 * @method static \Database\Factories\BeaconFactory factory(...$parameters)
 * @method static \Illuminate\Database\Eloquent\Builder|Beacon newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Beacon newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Beacon query()
 * @method static \Illuminate\Database\Eloquent\Builder|Beacon whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Beacon whereUuid($value)
 * @mixin \Eloquent
 */
class Beacon extends Model
{

    use HasFactory;

    public $timestamps = false;

    protected $table = 'beacons';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['uuid', 'name'];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [];
}

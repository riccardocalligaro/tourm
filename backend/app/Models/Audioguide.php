<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * App\Models\Audioguide
 *
 * @property int $id
 * @property string $title
 * @property int $language_id
 * @property int $room_id
 * @property string $path
 * @method static \Database\Factories\AudioguideFactory factory(...$parameters)
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide query()
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide whereLanguageId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide wherePath($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide whereRoomId($value)
 * @method static \Illuminate\Database\Eloquent\Builder|Audioguide whereTitle($value)
 * @mixin \Eloquent
 */
class Audioguide extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'audioguides';
}

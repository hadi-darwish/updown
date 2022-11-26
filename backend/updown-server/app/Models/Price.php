<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;


class Price extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     */
    protected $fillable = [
        'building_id',
        'tax',
        'price_per_travel',
        'start_date',
        'end_date',
    ];

    /**
     * The attributes that should be hidden for serialization.
     */

    protected $hidden = [
        'building_id',
    ];

    /**
     * Get the building that has the Price
     */

    public function building(): BelongsTo
    {
        return $this->belongsTo(Building::class);
    }
}

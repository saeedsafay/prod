<?php

class Comment extends Illuminate\Database\Eloquent\Model {

    protected $table = "comments";
    protected $guarded = [''];

    /**
     * Get the parent commentable model (post or video).
     */
    public function commentable()
    {
        return $this->morphTo();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user() {
        return $this->belongsTo("User");
    }

    /**
     * مدیریت وضعیت کامنت ها
     * @param  object  $obj
     * @return
     */
    public static function toggleStatus($obj) {
        if ($obj->status == 1)
            return $obj->update(['status' => 2]);
        elseif ($obj->status == 0)
            return $obj->update(['status' => 1]);
    }

}

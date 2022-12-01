<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش دسته بندی موضوعی محصول ' : 'افزودن دسته بندی موضوعی محصول '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked"
                      enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">

                            <div class="uk-margin-top uk-margin-bottom">
                                <label>مربوط به گروه کالایی</label>
                                <select name="product_type_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                    <option value="">انتخاب گروه کالا</option>
                                    {foreach $product_types as $val}
                                        <option value="{$val.id}"
                                                {if isset($thematicCategory) AND $thematicCategory->product_type_id eq $val.id
                                        || $set_product_type_id eq $val.id}
                                            selected=""
                                                {/if}>
                                            {$val.title}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <span class="error_page_content">
                                {form_error('product_type_id')}  
                            </span>
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان دسته بندی موضوعی محصول </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input title"
                                           name="title"
                                           value="{set_value('title', (isset($thematicCategory->title)) ? $thematicCategory->title : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>
                                <div class="uk-margin-top">
                                    <label>دسته بندی موضوعی والد</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-selectize" data-md-selectize-bottom="" name="parent_id">
                                            <option value="">انتخاب دسته</option>
                                            {foreach $titleArr as $categoryId => $val}
                                                {$title = implode(" > ", $val)}
                                                <option value="{$categoryId}"
                                                        {if $edit_mode && $thematicCategory->parent_id == $categoryId
                                                        || $set_parent_id == $categoryId}
                                                            selected
                                                        {/if}
                                                >
                                                    {$title}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('parent_id')}  
                                </span>

                            </div>
                        </div>
                    </div>
            </div>
        </div>
        <div class="uk-width-medium-1-4">
            <button type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span>
            </button>
        </div>
        </form>
    </div>
</div>
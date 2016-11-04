<div class="users form large-9 medium-8 columns content">
    <?= $this->Form->create($user) ?>
    <fieldset>
        <legend><?= __('Add User') ?></legend>
        <?php
            echo $this->Form->input('steam_id');
            echo $this->Form->input('country_code');
            echo $this->Form->input('age_range');
            echo $this->Form->input('role_id', ['options' => $roles, 'empty' => true]);
            echo $this->Form->input('rank');
            echo $this->Form->input('upvotes');
            echo $this->Form->input('downvotes');
            echo $this->Form->input('username');
            echo $this->Form->input('password');
            echo $this->Form->input('lobbys._ids', ['options' => $lobbys]);
        ?>
    </fieldset>
    <?= $this->Form->button(__('Submit')) ?>
    <?= $this->Form->end() ?>
</div>

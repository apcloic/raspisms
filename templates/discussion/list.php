<?php
	//Template dashboard
	
	$this->render('incs/head', ['title' => 'Discussions - Show All'])
?>
<div id="wrapper">
<?php
	$this->render('incs/nav', ['page' => 'discussions'])
?>
	<div id="page-wrapper">
		<div class="container-fluid">
			<!-- Page Heading -->
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">
						Dashboard <small>Discussions</small>
					</h1>
					<ol class="breadcrumb">
						<li>
							<i class="fa fa-dashboard"></i> <a href="<?php echo \Router::url('Dashboard', 'list'); ?>">Dashboard</a>
						</li>
						<li class="active">
							<i class="fa fa-comments-o"></i> Discussions
						</li>
					</ol>
				</div>
			</div>
			<!-- /.row -->

			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title"><i class="fa fa-comments-o fa-fw"></i> Liste des discussions</h3>
						</div>
						<div class="panel-body">
                            <?php if (!$discussions) { ?>
                                Aucune discussion n'est en cours actuellement.
                            <?php } else { ?>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped" id="table-discussions">
                                        <thead>
                                            <tr>
                                                <th>Date du dernier message</th>
                                                <th>Numéro</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($discussions as $discussion) { ?>
                                                        <tr class="goto" url="<?php $this->s(\Router::url('Discussion', 'show', ['number' => $discussion['number']])); ?>">
                                                        <td><?php $this->s($discussion['at']); ?></td>
                                                        <td><?php $this->s(isset($discussion['contact']) ? $discussion['contact'] . ' (' . $discussion['number'] . ')' : $discussion['number']); ?></td>
                                                    </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            <?php } ?>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<?php
	$this->render('incs/footer');
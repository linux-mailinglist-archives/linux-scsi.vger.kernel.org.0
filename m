Return-Path: <linux-scsi+bounces-25958-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOA5JeOgUGqD2gIAu9opvQ
	(envelope-from <linux-scsi+bounces-25958-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 09:36:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3373816C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 09:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bWiRIJMu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25958-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25958-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11821300FEE1
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Jul 2026 07:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7B38E8A8;
	Fri, 10 Jul 2026 07:32:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F16319859;
	Fri, 10 Jul 2026 07:32:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668750; cv=none; b=taYG7lrQa8upvThC6i90XtQX85clUFDXc8NMpQppw3RBd50c/0hd5fwJiYfNK9DJKYndbyjlnntsG5kBPi3bJMhUM5Qf9pYmb1cQrOyOLvxvktD698OFkrR5LDcQ29vXc9ODWOl+PQDYvHl6tznRRUqZNw6oa0/7ulDh4Lom4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668750; c=relaxed/simple;
	bh=tDz+HEp2tGb5ZwEzMlll9NOL9Mn6QPAXgcotayFIvlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp/4xbxWwcjZS+vOLyf5p01HpIo4MLCi5scGl70XJOqNfC4SffIiNBXfnhdtq97UhcpDsoyMrCRhdEFR00n6tkGH5/f+vg++UeZ2AlSKyUJq+1yqXXrtZvxWs7wXGnNq2xtuyLvnxLpZFHq5s/wi8fogmR2uAJN38ReHPMxYa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWiRIJMu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A81F000E9;
	Fri, 10 Jul 2026 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783668748;
	bh=BM/dGEL6lLliGw3VWwVwR+qlf1lGbJgL74Qlvdf8rcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bWiRIJMu9YkhCIdBT+lRNJDEvMdbXvkwzuk9uQJDtTexyDYTU9F7kqcOJpmf8HLBj
	 fJkMqgYWY2SFwkta/zbll5zTDWqgaJNhxvXiQuj51jlOPZWo8EXIgRJwupm7aTr/Pp
	 NGWIJ4yo85xlinLkbRtGm6tMBCQHF2g5JklBjxKZaXRcmmhaVjCYQVNyJnECsb9XkR
	 8xZTxguKnYqNgnvMujKEirXeL6nx3ixnvr0HLF8AgjlOZ+pHr2O50T/nVs5BUAsoZX
	 oVrpaWTqfSnqgX5iqSIOXX6IAaM8ZCT67NpdD6dFQWcy9GIajOPZyyZKDsAhDd0Xu5
	 nikjUiEbFtn3g==
Date: Fri, 10 Jul 2026 09:32:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>
Subject: Re: [PATCH v2 1/2] ata: libata-scsi: terminate deferred commands on
 time out
Message-ID: <alCgCE9PtbEWSqL9@fedora>
References: <20260710000646.1202200-1-dlemoal@kernel.org>
 <20260710000646.1202200-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710000646.1202200-2-dlemoal@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:martin.petersen@oracle.com,m:ipylypiv@google.com,m:john.g.garry@oracle.com,m:yanaijie@huawei.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25958-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFA3373816C

On Fri, Jul 10, 2026 at 09:06:45AM +0900, Damien Le Moal wrote:
> If a command timeout occurs while we have a deferred non-NCQ command
> waiting to be issued, the SCSI EH task is never woken up as the waiting
> deferred command is never issued nor completed, thus leaving this command
> to always be counted as "busy" for the SCSI host. This results in the
> scsi_error_handler() function test "shost->host_failed !=
> scsi_host_busy(shost))" to always be true, keeping the EH task sleeping.
> Eventuially, when the deferred command also times out, the SCSI EH task
> is woken up and the timeout processing occurs.
> 
> Avoid this unnecessary EH trigger additional wait time using the
> eh_timed_out SCSI host template operation. The function
> ata_scsi_eh_timed_out() is introduced to implement this operation using
> the helper function ata_scsi_port_eh_timed_out(). This function calls
> ata_scsi_requeue_deferred_qc() to force a requeue of deferred QCs, except
> for QCs that actually timed out. In this case,
> ata_scsi_cmd_error_handler() processing of timed out deferred QCs still
> applies.  Since the timeout itself and eventual re-issuing of deferred
> commands is not handled by this helper, SCSI_EH_NOT_HANDLED is returned
> to have scsi_timeout() continue with the regular timeout handling.
> 
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-eh.c   |  2 +-
>  drivers/ata/libata-scsi.c | 51 +++++++++++++++++++++++++++++++++------
>  drivers/ata/libata.h      |  3 ++-
>  include/linux/libata.h    |  2 ++
>  4 files changed, 48 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 05df7ea6954a..57d3d2d11dd8 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -951,7 +951,7 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
>  	 * If we have a deferred qc, requeue it so that it is retried once EH
>  	 * completes.
>  	 */
> -	ata_scsi_requeue_deferred_qc(ap);
> +	ata_scsi_requeue_deferred_qc(ap, NULL);
>  
>  	if (!fastdrain)
>  		return;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 5868526301a2..b6e25aab01d5 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1685,7 +1685,8 @@ void ata_scsi_deferred_qc_work(struct work_struct *work)
>  	spin_unlock_irqrestore(ap->lock, flags);
>  }
>  
> -void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap,
> +				  struct scsi_cmnd *timed_out_scmd)
>  {
>  	struct ata_link *link;
>  
> @@ -1694,16 +1695,19 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  	/*
>  	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
>  	 * do not try to be smart about what to do with this deferred command
> -	 * and simply requeue it by completing it with DID_REQUEUE.
> +	 * and simply requeue it by completing it with DID_REQUEUE. The
> +	 * exception here is if the deferred qc timed out, in which case, we
> +	 * leave it as is as ata_scsi_cmd_error_handler() will take care of it.
>  	 */
>  	ata_for_each_link(link, ap, PMP_FIRST) {
>  		struct ata_queued_cmd *qc = link->deferred_qc;

I like this patch much more than V1, as it does not duplicate the code which
specifically handles the case where the deferred QC timed out.

>  
> -		if (qc) {

Personally I would write this as:

if (qc && qc->scsicmd != timed_out_scmd)

to make the patch about 7 lines smaller.


> -			link->deferred_qc = NULL;
> -			cancel_work(&link->deferred_qc_work);
> -			ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
> -		}
> +		if (!qc || qc->scsicmd == timed_out_scmd)
> +			continue;
> +
> +		link->deferred_qc = NULL;
> +		cancel_work(&link->deferred_qc_work);
> +		ata_scsi_qc_done(qc, true, DID_REQUEUE << 16);
>  	}
>  }
>  


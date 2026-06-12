Return-Path: <linux-scsi+bounces-24892-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2n4TH6oFLGohJwQAu9opvQ
	(envelope-from <linux-scsi+bounces-24892-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:12:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 027ED679AA9
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 15:12:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=E5wAZXYY;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24892-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24892-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A693F3126BCD
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8353803D3;
	Fri, 12 Jun 2026 13:11:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D01EDA0F
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 13:11:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269901; cv=none; b=sNLnsdOqEqqjbTbb7KUkdOKYgfg9JX7Z5xnT5f+QhBzMcb+YdPg5GNqNbuDSa4cgILaWv8cUu23ND/jPlnTaUGclqLfDmVIy0zfieRkbb0YbCf1O53oYEPpbo4tZRKQD+duyl5qvndgXfoSdz3darv8lLYX7tnFQshOxmEUjzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269901; c=relaxed/simple;
	bh=1UNwdQJGqxPF6PjZS95PNBSMhtudX4Z5Dv0hambaU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vpcw4vX0oi6YSyly57g5reoYgczdZbcACVGRK4nAdmuvkvLC1vx+gGh9xb63A6IaM2Pp2Db/5pH5hvaNo0n0Wl7sY/2ZDts0tiRGeOsh7Okr/54WeMWVoKwl+mBq88j86W2xT0JONCwcCxPSjsNMrZi6aVg7ECGS0hudaueXTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5wAZXYY; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4908b92904fso9870055e9.0
        for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781269898; x=1781874698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ghz6ykIaUS4+C9ekglnkFROs1CUl6N5GeUpbI1xwiZ4=;
        b=E5wAZXYYx3gYSH16+XHmtB7PcOw+ueikyKVGUruy09O+UaPBi+/IzJnPHdtl77yOUa
         smHnO0fylKNScjwbrERca10/NL5xeASqIjjMhuyDRKIOE0M9yfTTUjU5Xjalt4mDkoPg
         pw4K3qHCaAqwGcj4lBa2Vc1sIZ7Hwp6MZpink0Mm8v8bvDMN1BBDfFSyRGTesI4eIIVI
         zNGaqwIYnHmf+Sv9LVprw8umhFHfjxDwNN2rK0ksNIdbBFU/yerHI+S2vHaXrq2Rajko
         wcgli1fpNFHk+7QNkOl4GhVrWl5XFLEEvXstM0+yj3Q0lzjxoCKxrAvexyus/tTUupiZ
         4qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269898; x=1781874698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ghz6ykIaUS4+C9ekglnkFROs1CUl6N5GeUpbI1xwiZ4=;
        b=MY57TZpmQsoUhGeGl8khqY7UIVaEb77HmHUrnczpHHNVZkDUbf36AqwFL9na/TPp4q
         oMYwgYTFTO4rE9KyE1R0OCAhcSBagN+QUN46glENYD27kYHL528kHUYB01ay0uzGb0UN
         4wl2rNsbN9vP/G9bE+vn1PMRL274rPMYhLV15kiin5jXgXJXOZVU7JQawLBo0T09nDYk
         CW5yPOzaO5ZtoRXZ6bZBcRBqVaUIsu0/L2FFAx4IS9zkJScRGyWbO+bsQSDj0wWAknE/
         kJxkaj1Zhdt43oO8U7rIAtmsdLDy5g6ymqc7RNmpOACa6yL+Rt5lwRDz/mZTlTX1AC9E
         jSdQ==
X-Gm-Message-State: AOJu0YwGqmmyBnvZMmN4XKkXwLdb19EMyL8BPKcNsQ3AHL8zwP41vW0D
	Zqxc8ygosAgBxWl6J6Jg239BQuNNfWEBGQXKG9mEbRUWBCDvN6fqC/tkHMS2dTNQL2c=
X-Gm-Gg: Acq92OEwDdbXRKr4FHtPzJdtLFBrYdRvN7hrD978ZODxIGzJJgCMQ4q4EduBDdfizS3
	D3uZIfEg5Qj+icz+RqUw423QbcAGDTSPwcwxcD4ZGSm201xnDZ+3AjAoLkk+BC2QirRTZaMnMWD
	lmFXxOdmvicX5hCeMaSxp24zbrJkszUQUI4C39r+Rg3EqXcrHdtulwYGGzz1qbe2RO7GHJAgT6p
	0DHzj2USw13jBBku5QaVku8dhMiTk4oH3FYB2rxdamA1jcQzv0qQ5Jh+mDorMOlGboxi30KuRXC
	Y3GcvUI6VQTtceRiMNDlSc6eiTIXfGfyveOsthZdyUHoyb1hH61xopw5Qrn0GFZla4Lo2gU0mdj
	CtAEq9/ynDgrsJigVvgHztWYd0OLuNOtXEXvrxEF8KGixpwZbwx7qTp+/AMI7LyyEttVBmhw1ie
	VEr4S2fJ1ke1C+1ExBlyXxqC40KpvbXj7gcjj6hhIl0qPEaQX07vTNbKcV
X-Received: by 2002:a05:600c:314a:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490ec504d2bmr35428345e9.20.1781269898070;
        Fri, 12 Jun 2026 06:11:38 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95b274sm66095345e9.1.2026.06.12.06.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 06:11:37 -0700 (PDT)
Message-ID: <996a5328-b17f-4c41-83b4-ed0e7a107f4a@suse.com>
Date: Fri, 12 Jun 2026 15:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 57/60] scsi: qla2xxx: Hold qpair lock when sending NVMe
 LS reject
To: Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, GR-FC-Storage-Upstream@marvell.com,
 agurumurthy@marvell.com, emilne@redhat.com, jmeneghi@redhat.com
References: <20260612095333.1666592-1-njavali@marvell.com>
 <20260612095333.1666592-58-njavali@marvell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260612095333.1666592-58-njavali@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-24892-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:njavali@marvell.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.com,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027ED679AA9

On 6/12/26 11:53, Nilesh Javali wrote:
> qla_nvme_ls_reject_iocb() allocates from and advances the request ring
> through __qla2x00_alloc_iocbs() (which assumes the hardware_lock is held)
> and qla2x00_start_iocbs() (which advances the ring and rings the
> request-in doorbell), but takes no lock itself. Two of its callers invoke
> it without the producer lock held:
> 
>    - qla_nvme_xmt_ls_rsp(), the NVMe-FC .xmt_ls_rsp transport callback, on
>      its error path, and
>    - qla2xxx_process_purls_pkt(), run from the purex work/DPC context.
> 
> Both use ha->base_qpair, whose qp_lock_ptr is hardware_lock, so they can
> run concurrently with normal I/O submission on the base ring and corrupt
> the ring producer state, leading to duplicated or dropped commands. The
> third caller, qla2xxx_process_purls_iocb(), runs inside
> qla24xx_process_response_queue() with the qpair lock already held and is
> safe; that is also why the lock cannot be taken inside the helper itself
> (it would recursively re-acquire hardware_lock on the response path).
> 
> Take qp_lock_ptr around the two unlocked callers and document the helper
> as caller-locked. Both run in process context, so spin_lock_irqsave() is
> used and nothing in the locked region sleeps.
> 
> Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nilesh Javali <njavali@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_nvme.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index 3b2f255a5d7d..8dc6df6c2e1c 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -374,6 +374,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
>   	srb_t *sp;
>   	int rval = QLA_FUNCTION_FAILED;
>   	uint8_t cnt = 0;
> +	unsigned long flags;
>   
>   	if (!fcport || fcport->deleted)
>   		goto out;
> @@ -440,7 +441,9 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
>   	a.vp_idx = vha->vp_idx;
>   	a.nport_handle = uctx->nport_handle;
>   	a.xchg_address = uctx->exchange_address;
> +	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
>   	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
> +	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
>   	kfree(uctx);
>   	return rval;
>   }
> @@ -1243,6 +1246,10 @@ static void qla_nvme_lsrjt_pt_iocb(struct scsi_qla_host *vha,
>   	}
>   }
>   
> +/*
> + * Allocates from and advances the request ring, so the caller must hold
> + * qp->qp_lock_ptr (the response-queue caller already holds it).
> + */
>   static int
>   qla_nvme_ls_reject_iocb(struct scsi_qla_host *vha, struct qla_qpair *qp,
>   			struct qla_nvme_lsrjt_pt_arg *a, bool is_xchg_terminate)
> @@ -1299,6 +1306,7 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
>   {
>   	struct qla_nvme_unsol_ctx *uctx = item->purls_context;
>   	struct qla_nvme_lsrjt_pt_arg a;
> +	unsigned long flags;
>   	int ret = 1;
>   
>   #if (IS_ENABLED(CONFIG_NVME_FC))
> @@ -1311,7 +1319,9 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
>   		a.vp_idx = vha->vp_idx;
>   		a.nport_handle = uctx->nport_handle;
>   		a.xchg_address = uctx->exchange_address;
> +		spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr, flags);
>   		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
> +		spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr, flags);
>   		list_del(&uctx->elem);
>   		kfree(uctx);
>   	}

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6031F1279
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jun 2020 07:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgFHFdB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 8 Jun 2020 01:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHFdB (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 8 Jun 2020 01:33:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E4F2074B;
        Mon,  8 Jun 2020 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591594381;
        bh=GTpf7raXQwCfFtoKplkeklGcNmatbNaUSfsYy/Yygt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXqr/wi6VwVG7CzAGrlSLq065Wf9fi4fPo/fi4sakAQoZps9daVKDa6zms2Go6pUc
         orfwHTZJeQ2WUV+6/Y0zVRJTDz2ZmVO9HD5k2vp2xI0Z6QVwey3sxThGfe2fi2kD3x
         PQwtNPegkKkCH5+nMM3Zq7Md32BQlm/Mc7Stce5w=
Date:   Mon, 8 Jun 2020 07:32:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, bstroesser@ts.fujitsu.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH 11/17] target: add session sysfs class support
Message-ID: <20200608053259.GA241877@kroah.com>
References: <1591562164-9766-1-git-send-email-michael.christie@oracle.com>
 <1591562164-9766-12-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591562164-9766-12-git-send-email-michael.christie@oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Jun 07, 2020 at 03:35:58PM -0500, Mike Christie wrote:
> +int target_sysfs_add_session(struct se_portal_group *se_tpg,
> +			     struct se_session *se_sess)
> +{
> +	struct t10_transport_id *tpt_id = se_sess->tpt_id;
> +	int ret;
> +
> +	if (!try_module_get(se_sess->tfo->module))
> +		return -EINVAL;
> +
> +	ret = target_cp_endpoint_strs(se_tpg, se_sess);
> +	if (ret)
> +		goto put_mod;
> +
> +	se_sess->dev.groups = se_sess->tfo->session_attr_groups;
> +	ret = device_add(&se_sess->dev);
> +	if (ret) {
> +		pr_err("Could not add session%d to sysfs. Error %d.\n",
> +		       se_sess->sid, ret);
> +		goto free_ep_strs;
> +	}
> +
> +	pr_info("TCM added session-%d from [fabric: %s, target: %s, tpg %s, acl: %s] to [initiator port: %s%s%s]",
> +		se_sess->sid, se_sess->fabric_name, se_sess->target_name,
> +		se_sess->tpg_name, se_sess->acl_name ? se_sess->acl_name : "dynamic",
> +		tpt_id->name, tpt_id->session_id ? "," : "",
> +		tpt_id->session_id ? tpt_id->session_id : "");

You have a 'struct device', so please use it, no need for pr_info(),
always use the dev_*() calls instead.

but, when drivers and kernel code is all working properly, no need to be
noisy at all, this should just be a dev_dbg() call, right?

> +
> +	se_sess->sysfs_added = true;
> +	return 0;
> +
> +free_ep_strs:
> +	target_free_endpoint_strs(se_sess);
> +put_mod:
> +	module_put(se_sess->tfo->module);
> +	return ret;
> +}
> +EXPORT_SYMBOL(target_sysfs_add_session);

I have to ask, EXPORT_SYMBOL_GPL()?

> +
> +void target_sysfs_remove_session(struct se_session *se_sess)
> +{
> +	struct t10_transport_id *tpt_id = se_sess->tpt_id;
> +
> +	/* discovery sessions are normally not added to sysfs */
> +	if (!se_sess->sysfs_added)
> +		return;
> +	se_sess->sysfs_added = false;
> +
> +	pr_info("TCM removed session-%d from [fabric: %s, target: %s, tpg %s, acl: %s] to [initiator port: %s%s%s]",
> +		se_sess->sid, se_sess->fabric_name, se_sess->target_name,
> +		se_sess->tpg_name, se_sess->acl_name ? se_sess->acl_name : "dynamic",
> +		tpt_id->name, tpt_id->session_id ? "," : "",
> +		tpt_id->session_id ? tpt_id->session_id : "");

dev_dbg()?

> +
> +	device_del(&se_sess->dev);
> +}
> +EXPORT_SYMBOL(target_sysfs_remove_session);

EXPORT_SYMBOL_GPL()?

> +
> +void target_sysfs_init(void)
> +{
> +	class_register(&session_class);

Why not:
	return class_register(&session_class);

you lost the return value of that call :(

Other than those minor things, looks good, nice job!

greg k-h

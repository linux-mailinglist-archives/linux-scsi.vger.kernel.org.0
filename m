Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A78318E0E
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Feb 2021 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhBKPUH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 10:20:07 -0500
Received: from verein.lst.de ([213.95.11.211]:55791 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBKPRs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Feb 2021 10:17:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26D0968CF0; Thu, 11 Feb 2021 16:16:57 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:16:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 13/14] tcm_fc: Convert to new submission API
Message-ID: <20210211151656.GK22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-14-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-14-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> +	if (target_init_cmd(&cmd->se_cmd, cmd->sess->se_sess,
> +			    &cmd->ft_sense_buffer[0], scsilun_to_int(&fcp->fc_lun),
> +			    ntohl(fcp->fc_dl), task_attr, data_dir,

It would be nice to avoid the overly long line here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

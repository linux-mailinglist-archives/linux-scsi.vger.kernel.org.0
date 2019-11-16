Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E23FF3E6
	for <lists+linux-scsi@lfdr.de>; Sat, 16 Nov 2019 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKPQbX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 16 Nov 2019 11:31:23 -0500
Received: from verein.lst.de ([213.95.11.211]:49379 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKPQbW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 16 Nov 2019 11:31:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45ADB68BE1; Sat, 16 Nov 2019 17:31:21 +0100 (CET)
Date:   Sat, 16 Nov 2019 17:31:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/5] dpt_i2o: use midlayer tcq implementation
Message-ID: <20191116163120.GC23951@lst.de>
References: <20191115122757.132006-1-hare@suse.de> <20191115122757.132006-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115122757.132006-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Nov 15, 2019 at 01:27:54PM +0100, Hannes Reinecke wrote:
> +	cmd->result = (DID_OK << 16) | SAM_STAT_TASK_SET_FULL;
> +	cmd->scsi_done(cmd);
>  
> +	return true;
> +}
> +
> +static void adpt_fail_posted_scbs(adpt_hba* pHba)
> +{
> +	scsi_host_busy_iter(pHba->host, fail_posted_scbs_iter, NULL);

I still think that SAM_STAT_TASK_SET_FULL is a very strange error here,
and that we should have a helper like adpt_fail_posted_scbs in the
core SCSI code.  Also your * placement is wrong above.

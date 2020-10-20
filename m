Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C932935EA
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Oct 2020 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgJTHip (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Oct 2020 03:38:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbgJTHio (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 20 Oct 2020 03:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E78CAD1E;
        Tue, 20 Oct 2020 07:38:43 +0000 (UTC)
Date:   Tue, 20 Oct 2020 09:38:41 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Ram Vegesna <ram.vegesna@broadcom.com>
Subject: Re: [PATCH v4 05/31] elx: libefc_sli: Populate and post different
 WQEs
Message-ID: <20201020073841.a2hr5qwssr262hib@beryllium.lan>
References: <20201012225147.54404-1-james.smart@broadcom.com>
 <20201012225147.54404-6-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012225147.54404-6-james.smart@broadcom.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Oct 12, 2020 at 03:51:21PM -0700, James Smart wrote:
> This patch continues the libefc_sli SLI-4 library population.
> 
> This patch adds service routines to create different WQEs and adds
> APIs to issue iread, iwrite, treceive, tsend and other work queue
> entries.
> 
> Co-developed-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
> Signed-off-by: James Smart <james.smart@broadcom.com>

Looks goods to me.

Reviewed-by: Daniel Wagner <dwagner@suse.de>




> +	case SLI4_CQE_CODE_RELEASE_WQE: {
> +		struct sli4_fc_wqec *wqec = (void *)cqe;
> +
> +		*etype = SLI4_QENTRY_WQ_RELEASE;
> +		*r_id = le16_to_cpu(wqec->wq_id);
> +		rc = EFC_SUCCESS;
> +		break;
> +	}

Nitpick, the rest of the cases do

	case XXX :
	{
		[...]
	}

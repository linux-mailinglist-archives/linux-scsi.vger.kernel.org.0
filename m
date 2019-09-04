Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6972EA8DA0
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Sep 2019 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfIDRXl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Sep 2019 13:23:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:18319 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbfIDRXk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Sep 2019 13:23:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="383550359"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2019 10:23:38 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i5Z0L-0004UW-2P; Wed, 04 Sep 2019 20:23:37 +0300
Date:   Wed, 4 Sep 2019 20:23:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-scsi@vger.kernel.org, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 1/1] scsi: lpfc: Convert existing %pf users to %ps
Message-ID: <20190904172337.GW2680@smile.fi.intel.com>
References: <20190904160423.3865-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904160423.3865-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 04, 2019 at 07:04:23PM +0300, Sakari Ailus wrote:
> Convert the remaining %pf users to %ps to prepare for the removal of the
> old %pf conversion specifier support.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 323506644972 ("scsi: lpfc: Migrate to %px and %pf in kernel print calls")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/scsi/lpfc/lpfc_hbadisc.c | 4 ++--
>  drivers/scsi/lpfc/lpfc_sli.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index e7463d561f305..749286acdc173 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6051,7 +6051,7 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
>  	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
>  		if (filter(ndlp, param)) {
>  			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
> -					 "3185 FIND node filter %pf DID "
> +					 "3185 FIND node filter %ps DID "
>  					 "ndlp x%px did x%x flg x%x st x%x "
>  					 "xri x%x type x%x rpi x%x\n",
>  					 filter, ndlp, ndlp->nlp_DID,
> @@ -6062,7 +6062,7 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
>  		}
>  	}
>  	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
> -			 "3186 FIND node filter %pf NOT FOUND.\n", filter);
> +			 "3186 FIND node filter %ps NOT FOUND.\n", filter);
>  	return NULL;
>  }
>  
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index bb5705267c395..2ff0879a95126 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -2712,7 +2712,7 @@ lpfc_sli_handle_mb_event(struct lpfc_hba *phba)
>  
>  		/* Mailbox cmd <cmd> Cmpl <cmpl> */
>  		lpfc_printf_log(phba, KERN_INFO, LOG_MBOX | LOG_SLI,
> -				"(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl %pf "
> +				"(%d):0307 Mailbox cmd x%x (x%x/x%x) Cmpl %ps "
>  				"Data: x%x x%x x%x x%x x%x x%x x%x x%x x%x "
>  				"x%x x%x x%x\n",
>  				pmb->vport ? pmb->vport->vpi : 0,
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko



Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C82B3DF1
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Nov 2020 08:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgKPHuy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Nov 2020 02:50:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHuy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 16 Nov 2020 02:50:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 883EEAF96;
        Mon, 16 Nov 2020 07:50:52 +0000 (UTC)
Subject: Re: [PATCH v4 07/19] lpfc: vmid: Forward declarations for APIs
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-8-git-send-email-muneendra.kumar@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a88e24ae-159e-4cbc-9142-63c21cd85413@suse.de>
Date:   Mon, 16 Nov 2020 08:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-8-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/9/20 5:23 AM, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> 
> This patch contains the forward declarations of commonly used APIs which
> are used outside the scope of the file.
> 
> Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v4:
> No change
> 
> v3:
> No change
> 
> v2:
> Ported the patch on top of 5.10/scsi-queue
> ---
>   drivers/scsi/lpfc/lpfc_crtn.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
> index 782f6f76f18a..74ca5860ca8e 100644
> --- a/drivers/scsi/lpfc/lpfc_crtn.h
> +++ b/drivers/scsi/lpfc/lpfc_crtn.h
> @@ -600,3 +600,14 @@ extern int lpfc_enable_nvmet_cnt;
>   extern unsigned long long lpfc_enable_nvmet[];
>   extern int lpfc_no_hba_reset_cnt;
>   extern unsigned long lpfc_no_hba_reset[];
> +
> +/* vmid interface */
> +int lpfc_vmid_uvem(struct lpfc_vport *vport, struct lpfc_vmid *vmid, bool ins);
> +u32 lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport);
> +int lpfc_vmid_cmd(struct lpfc_vport *vport,
> +		  int cmdcode, struct lpfc_vmid *vmid);
> +int lpfc_vmid_hash_fn(char *vmid, int len);
> +struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
> +					      u32 hash, u8 *buf);
> +void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
> +int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
> 
uint32_t ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

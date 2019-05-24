Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86C29C59
	for <lists+linux-scsi@lfdr.de>; Fri, 24 May 2019 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfEXQco (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 May 2019 12:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390210AbfEXQco (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 May 2019 12:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 483E230C1209;
        Fri, 24 May 2019 16:32:39 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF6CB10027BC;
        Fri, 24 May 2019 16:32:38 +0000 (UTC)
Message-ID: <d1a5b8e1803c06164847da296e7c1ff712aa213b.camel@redhat.com>
Subject: Re: [PATCH 19/21] lpfc: Fix BFS crash with t10-dif enabled.
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>
Date:   Fri, 24 May 2019 12:32:38 -0400
In-Reply-To: <20190522004911.573-20-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
         <20190522004911.573-20-jsmart2021@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 24 May 2019 16:32:44 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 2019-05-21 at 17:49 -0700, James Smart wrote:
> Crashes in scsi_queue_rq or in dma_unmap_direct_sg during BFS when
> lpfc has lpfc_enable_bg=1.
> 
> lpfc is setting the t10-dif and prot sg after scsi_add_host_with_dma()
> has been called. The scsi_host_set_prot() and scsi_host_set_guard()
> routines need to be called before scsi_add_host_with_dma().
> 
> Revise the calling sequence to set the protection/guard data before
> calling scsi_add_host_with_dma().
> 
> Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 416f0fb155f5..a2b827dd36ff 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -94,6 +94,7 @@ static void lpfc_sli4_disable_intr(struct lpfc_hba *);
>  static uint32_t lpfc_sli4_enable_intr(struct lpfc_hba *, uint32_t);
>  static void lpfc_sli4_oas_verify(struct lpfc_hba *phba);
>  static uint16_t lpfc_find_cpu_handle(struct lpfc_hba *, uint16_t, int);
> +static void lpfc_setup_bg(struct lpfc_hba *, struct Scsi_Host *);
>  
>  static struct scsi_transport_template *lpfc_transport_template = NULL;
>  static struct scsi_transport_template *lpfc_vport_transport_template = NULL;
> @@ -4348,6 +4349,9 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
>  
>  	timer_setup(&vport->delayed_disc_tmo, lpfc_delayed_disc_tmo, 0);
>  
> +	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED)
> +		lpfc_setup_bg(phba, shost);
> +
>  	error = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
>  	if (error)
>  		goto out_put_shost;
> @@ -7669,8 +7673,6 @@ lpfc_post_init_setup(struct lpfc_hba *phba)
>  	 */
>  	shost = pci_get_drvdata(phba->pcidev);
>  	shost->can_queue = phba->cfg_hba_queue_depth - 10;
> -	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED)
> -		lpfc_setup_bg(phba, shost);
>  
>  	lpfc_host_attrib_init(shost);
>  

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


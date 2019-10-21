Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A882CDF7D9
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Oct 2019 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfJUWMy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Oct 2019 18:12:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52142 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWMy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Oct 2019 18:12:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 75EDB29E5C;
        Mon, 21 Oct 2019 18:12:50 -0400 (EDT)
Date:   Tue, 22 Oct 2019 09:12:48 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 10/24] scsi: introduce set_status_byte()
In-Reply-To: <20191021095322.137969-11-hare@suse.de>
Message-ID: <alpine.LNX.2.21.1910220911390.8@nippy.intranet>
References: <20191021095322.137969-1-hare@suse.de> <20191021095322.137969-11-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 21 Oct 2019, Hannes Reinecke wrote:

> To be in-line with the other set_XX_byte() functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  include/scsi/scsi_cmnd.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> index 91bd749a02f7..6932d91472d5 100644
> --- a/include/scsi/scsi_cmnd.h
> +++ b/include/scsi/scsi_cmnd.h
> @@ -307,6 +307,11 @@ static inline struct scsi_data_buffer *scsi_prot(struct scsi_cmnd *cmd)
>  #define scsi_for_each_prot_sg(cmd, sg, nseg, __i)		\
>  	for_each_sg(scsi_prot_sglist(cmd), sg, nseg, __i)
>  
> +static inline void set_status_byte(struct scsi_cmnd *cmd, char status)
> +{
> +	cmd->result = (cmd->result & 0xffffff00) | status;

Is sign-extension desirable here? Do callers need it?

-- 

> +}
> +
>  static inline void set_msg_byte(struct scsi_cmnd *cmd, char status)
>  {
>  	cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
> 

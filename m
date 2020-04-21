Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2951B2AF2
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDUPR3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 Apr 2020 11:17:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbgDUPR3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 21 Apr 2020 11:17:29 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E1CC71CC61834FD3D317;
        Tue, 21 Apr 2020 16:17:26 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 21 Apr
 2020 16:17:26 +0100
Subject: Re: [PATCH] scsi: put hot fields of scsi_host_template into one
 cacheline
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200421124952.297448-1-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <367d58f7-722d-16db-3e90-50dc9fd4e078@huawei.com>
Date:   Tue, 21 Apr 2020 16:16:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200421124952.297448-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.25]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 21/04/2020 13:49, Ming Lei wrote:
> The following three fields of scsi_host_template are referenced in
> scsi IO submission path, so put them together into one cacheline:
> 
> - cmd_size
> - queuecommand
> - commit_rqs
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   include/scsi/scsi_host.h | 67 +++++++++++++++++++++-------------------
>   1 file changed, 35 insertions(+), 32 deletions(-)
> 
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 822e8cda8d9b..959dc5160f72 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -33,37 +33,12 @@ struct scsi_host_template {
>   	struct module *module;
>   	const char *name;
>   
> -	/*
> -	 * The info function will return whatever useful information the
> -	 * developer sees fit.  If not provided, then the name field will
> -	 * be used instead.
> -	 *
> -	 * Status: OPTIONAL
> -	 */
> -	const char *(* info)(struct Scsi_Host *);
> +	/* Put hot fields together in same cacheline */
>   
>   	/*
> -	 * Ioctl interface
> -	 *
> -	 * Status: OPTIONAL
> -	 */
> -	int (*ioctl)(struct scsi_device *dev, unsigned int cmd,
> -		     void __user *arg);
> -
> -
> -#ifdef CONFIG_COMPAT
> -	/*
> -	 * Compat handler. Handle 32bit ABI.
> -	 * When unknown ioctl is passed return -ENOIOCTLCMD.
> -	 *
> -	 * Status: OPTIONAL
> +	 * Additional per-command data allocated for the driver.
>   	 */
> -	int (*compat_ioctl)(struct scsi_device *dev, unsigned int cmd,
> -			    void __user *arg);
> -#endif
> -
> -	int (*init_cmd_priv)(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
> -	int (*exit_cmd_priv)(struct Scsi_Host *shost, struct scsi_cmnd *cmd);

Should new member .init_cmd_priv be included also in the "hot" group? 
Even if NULL generally, we still have to load that from memory to know 
it (is NULL) in scsi_mq_init_request() and scsi_init_command() [which 
are fastpath, right?]

Cheers,
John


> +	unsigned int cmd_size;
>   
>   	/*
>   	 * The queuecommand function is used to queue up a scsi
> @@ -111,6 +86,38 @@ struct scsi_host_template {
>   	 */
>   	void (*commit_rqs)(struct Scsi_Host *, u16);
>   
> +	/*
> +	 * The info function will return whatever useful information the
> +	 * developer sees fit.  If not provided, then the name field will
> +	 * be used instead.
> +	 *
> +	 * Status: OPTIONAL
> +	 */
> +	const char *(* info)(struct Scsi_Host *);
> +
> +	/*
> +	 * Ioctl interface
> +	 *
> +	 * Status: OPTIONAL
> +	 */
> +	int (*ioctl)(struct scsi_device *dev, unsigned int cmd,
> +		     void __user *arg);
> +
> +
> +#ifdef CONFIG_COMPAT
> +	/*
> +	 * Compat handler. Handle 32bit ABI.
> +	 * When unknown ioctl is passed return -ENOIOCTLCMD.
> +	 *
> +	 * Status: OPTIONAL
> +	 */
> +	int (*compat_ioctl)(struct scsi_device *dev, unsigned int cmd,
> +			    void __user *arg);
> +#endif
> +
> +	int (*init_cmd_priv)(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
> +	int (*exit_cmd_priv)(struct Scsi_Host *shost, struct scsi_cmnd *cmd);
> +
>   	/*
>   	 * This is an error handling strategy routine.  You don't need to
>   	 * define one of these if you don't want to - there is a default
> @@ -468,10 +475,6 @@ struct scsi_host_template {
>   	 */
>   	u64 vendor_id;
>   
> -	/*
> -	 * Additional per-command data allocated for the driver.
> -	 */
> -	unsigned int cmd_size;
>   	struct scsi_host_cmd_pool *cmd_pool;
>   
>   	/* Delay for runtime autosuspend */
> 


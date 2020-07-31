Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7E234D64
	for <lists+linux-scsi@lfdr.de>; Sat,  1 Aug 2020 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGaV6j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 Jul 2020 17:58:39 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:40068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbgGaV6j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 Jul 2020 17:58:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9E9D8180A7FEE;
        Fri, 31 Jul 2020 21:58:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:968:988:989:1260:1277:1311:1313:1314:1345:1359:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3868:4321:4385:5007:6119:7903:8603:10004:10400:10848:11026:11232:11233:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:5,LUA_SUMMARY:none
X-HE-Tag: chalk56_561320126f87
X-Filterd-Recvd-Size: 1949
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 21:58:37 +0000 (UTC)
Message-ID: <33d943d2b83f17371df09b5962c856ea2d894954.camel@perches.com>
Subject: Re: [PATCH] scsi: libcxgbi: use kvzalloc instead of opencoded
 kzalloc/vzalloc
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 31 Jul 2020 14:58:36 -0700
In-Reply-To: <20200731215524.14295-1-efremov@linux.com>
References: <20200731215524.14295-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2020-08-01 at 00:55 +0300, Denis Efremov wrote:
> Remove cxgbi_alloc_big_mem(), cxgbi_free_big_mem() functions
> and use kvzalloc/kvfree instead.

Sensible, thanks.

> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
[]
> @@ -77,9 +77,9 @@ int cxgbi_device_portmap_create(struct cxgbi_device *cdev, unsigned int base,
>  {
>  	struct cxgbi_ports_map *pmap = &cdev->pmap;
>  
> -	pmap->port_csk = cxgbi_alloc_big_mem(max_conn *
> -					     sizeof(struct cxgbi_sock *),
> -					     GFP_KERNEL);
> +	pmap->port_csk = kvzalloc(array_size(max_conn,
> +					     sizeof(struct cxgbi_sock *)),
> +				  GFP_KERNEL);

missing __GFP_NOWARN

> diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
[]
> @@ -537,22 +537,6 @@ struct cxgbi_task_data {
>  #define iscsi_task_cxgbi_data(task) \
>  	((task)->dd_data + sizeof(struct iscsi_tcp_task))
>  
> -static inline void *cxgbi_alloc_big_mem(unsigned int size,
> -					gfp_t gfp)
> -{
> -	void *p = kzalloc(size, gfp | __GFP_NOWARN);



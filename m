Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CC281A5B
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Oct 2020 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbgJBSBm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Oct 2020 14:01:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55568 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSBm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Oct 2020 14:01:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092Hs2jE001874;
        Fri, 2 Oct 2020 18:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rnq1TPnApAb1bEkzjDsdjc0Ka2t0OY8u7KUNx1GDfXg=;
 b=FoJN4Rr7vDFopWjzucXOclx+6TYkwjt83HY4vJJ5rFLU4zw2eXgj2Z9n1CEzgujrokCa
 voIZUzvkhzMBrxOK84bKLwKweQT/kPimQkatsSmlGsi2uDrZYIZec9Apmol+DkX26+1R
 ClMVozCHq1gvmF3nr7OHOjeR9TzmuIZgg+/xC7twh5b4BAQfH2kk7HI+FMj5LqfGXA6q
 yjNKzpb4UQ9hxmLQPt6KfkY5ALaIP9z/oShdM49IQ/bdb4ZDOglvE/STPPQab+h69kJq
 zn0mOApQPFp5sc2Sf2FTNiD5wnr60lBazoHyrADf9E9hgApCTM1RdTVTdIm6NAULyadA Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33wupg343p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 18:01:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092Hotnf133105;
        Fri, 2 Oct 2020 18:01:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33tfdxwvf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 18:01:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 092I1b7n006303;
        Fri, 2 Oct 2020 18:01:37 GMT
Received: from [20.15.0.202] (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 11:01:37 -0700
Subject: Re: [PATCH ] scsi: page warning: 'page' may be used uninitialized
To:     john.p.donnelly@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, bstroesser@ts.fujitsu.com
References: <20200924001920.43594-1-john.p.donnelly@oracle.com>
From:   Mike Christie <michael.christie@oracle.com>
Message-ID: <9c22ec6b-7487-300b-e376-b05297a5d0bc@oracle.com>
Date:   Fri, 2 Oct 2020 13:01:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924001920.43594-1-john.p.donnelly@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020131
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/23/20 7:19 PM, john.p.donnelly@oracle.com wrote:
> From: John Donnelly <john.p.donnelly@oracle.com>
> 
> corrects: drivers/target/target_core_user.c:688:6: warning: 'page' may be used
> uninitialized
> 
> Fixes: 3c58f737231e ("scsi: target: tcmu: Optimize use of
> flush_dcache_page")
> 
> To: linux-scsi@vger.kernel.org
> Cc: Mike Christie <michael.christie@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  drivers/target/target_core_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index 9b7592350502..86b28117787e 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -681,7 +681,7 @@ static void scatter_data_area(struct tcmu_dev *udev,
>  	void *from, *to = NULL;
>  	size_t copy_bytes, to_offset, offset;
>  	struct scatterlist *sg;
> -	struct page *page;
> +	struct page *page = NULL;
>  
>  	for_each_sg(data_sg, sg, data_nents, i) {
>  		int sg_remaining = sg->length;
> 

Looks ok for now. In the next kernel we can do the more invasive approach and
add a new struct/helpers to make the code cleaner and fix it properly.

Acked-by: Mike Christie <michael.christie@oracle.com>

Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EEA273974
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 05:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgIVD5b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 23:57:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41976 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgIVD53 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Sep 2020 23:57:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3o8BX149608;
        Tue, 22 Sep 2020 03:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=d2R/rFJyFFbDTQszJOYDwJHlY1MUjsoVUS3AJgNXJXM=;
 b=AxEn5iRQgWadOSMF+xsJ4vknODA70en+WGpwzROchRyzVApy8le17iuk0vZqqiJHb1j2
 hvVJR0HTNqydKIaLNnRh6nzFFm++wFH9I4Plo9kiqNCTAfS/D1ob41PcZ5tl1ZMJapDD
 qo269R8aO57oY6kMEdTCZdspbx0JmmR5Ki54wimDAxzWbSkcEpEJ/U4Q2M4hYo6otYsd
 a4S9SnWWsVm12YILzI6JYKfWee/XgEl8s1EIoQfzzUbmVWHl+aDkcrsfBojvMn+sOAVz
 ieY76tOpm1zXPDYhAMKZr6XXT+7++6C5m57orKATkhLkILozPCnPFtgrtUmaLEuQ1lNh Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33n7gad5sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:57:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3uMAA073630;
        Tue, 22 Sep 2020 03:57:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurs30uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:57:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08M3vN58019143;
        Tue, 22 Sep 2020 03:57:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:57:23 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, Tomas Henzl <thenzl@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, sathya.prakash@broadcom.com
Subject: Re: [PATCH] mpt3sas: fix sync irqs
Date:   Mon, 21 Sep 2020 23:56:54 -0400
Message-Id: <160074695009.411.12767969040209762752.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910142126.8147-1-thenzl@redhat.com>
References: <20200910142126.8147-1-thenzl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=721 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=753 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220030
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 10 Sep 2020 16:21:26 +0200, Tomas Henzl wrote:

> - _base_process_reply_queue called from _base_interrupt
> may schedule a new irq poll, fix this by calling
> synchronize_irq first
> - a fix for "Unbalanced enable for IRQ..."
> enable_irq should be called only when necessary

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: mpt3sas: Fix sync irqs
      https://git.kernel.org/mkp/scsi/c/45181eab8ba7

-- 
Martin K. Petersen	Oracle Linux Engineering

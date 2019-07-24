Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74572467
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Jul 2019 04:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfGXCW0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 22:22:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGXCWZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 Jul 2019 22:22:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2IcGu127041;
        Wed, 24 Jul 2019 02:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=O3L0hEVKDKZnrEZsfBbbw5fx4ZV/eyWU7SgYXlGHE/8=;
 b=eNk/msqA2asOeZQzRx7y0ku1Qld1bJ+tfZh6EhXp/rlv0B2DDl5yJEjf7nqzlG4LVSKt
 vjfa+88VpqtDXAjzNCgSA3URlmR52OeeZe8wW/l9A78j2ATfskJeogJ2huR+hx+rPl/i
 T+32nNofbjuKa0Msx9Sa7UcBE5YjAskCiai6w9f/gnhBfOKfziAtDR5+jTY25aWD7IwX
 i4E4dP470ln029BjQWNsgZfBTSEHq/MzikEjBhcKHRTIWLTxA/WalJj0vDC8VxlYUJBm
 97fNL2VmeCShQPe0jdYtlZPdz/CUkitd25cngPFglITcEq04cwVlZk4Z1Rc6/n5mKm/i Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tx61bt7q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:22:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2IXBT072941;
        Wed, 24 Jul 2019 02:22:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tx60wy8v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:22:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6O2MKYF021853;
        Wed, 24 Jul 2019 02:22:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:22:20 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 0/3] Fix more magic values in the Future Domain drivers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com>
Date:   Tue, 23 Jul 2019 22:22:18 -0400
In-Reply-To: <a6fcf19e-d8ed-80c6-6d5a-53f143c08d99@cogentembedded.com> (Sergei
        Shtylyov's message of "Tue, 16 Jul 2019 23:37:16 +0300")
Message-ID: <yq1blxkqihx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240024
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Sergei,

> Here's a set of 3 patches against the Linus' repo. The recently
> resurrected Future Domain SCSI driver got a facelift by Ondrej (thank
> you!); however, several magic numbers were overlooked, so I went and
> fixed these cases.
>
> Future Domain's stuff isn't new to me -- I wrote a FD SCSI driver for
> another OS back in '90s... I thought I might still have a real card
> somewhere in my flat but none were found... :-(

Ondrej: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering

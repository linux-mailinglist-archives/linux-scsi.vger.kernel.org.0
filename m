Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7754E1012A6
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Nov 2019 05:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSEso (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 23:48:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39172 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKSEso (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Nov 2019 23:48:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4meXP094218;
        Tue, 19 Nov 2019 04:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=lYrKgEhVIW3PU7OvdVxFYZhJlL09AfYlXmFfwYwyFfg=;
 b=GCfhIldb45TSkItRtW9bAjWYxOve/bQJHFOWqFz6Gg2YPKSeW+R/WpPLjFbKWsSBFLgO
 IZeW0u2D0hW0YvYu/IUKtUKUNH4fk2+baoJZo8Rx8N/k1CBecun1WpT/rMNwNkkJ25w0
 2ettLQj3IDYdCy1ZwWN3cHsmKoM49LL+UpLtSJ7X0n08LPh68YEXVTxtkCyPA40Ni6/l
 k+7iVh4EbAKbIGmQNaPIaGoqiPfJMiyw5GP7u2JitXAdlInakY2DA09bLqFQ3ofbyWOm
 NvGzMWGIHmR7p7v0/P3+0pgPC/9hDNUK6+rnVUVTrT3jsTlDQQf7KIVitVHuZbKHwhP6 mw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wa92pmchc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 04:48:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4gXNt096970;
        Tue, 19 Nov 2019 04:46:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgdygp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 04:46:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAJ4kZCO004934;
        Tue, 19 Nov 2019 04:46:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 20:46:35 -0800
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NCR5380: Add disconnect_mask module parameter
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <993b17545990f31f9fa5a98202b51102a68e7594.1573875417.git.fthain@telegraphics.com.au>
Date:   Mon, 18 Nov 2019 23:46:32 -0500
In-Reply-To: <993b17545990f31f9fa5a98202b51102a68e7594.1573875417.git.fthain@telegraphics.com.au>
        (Finn Thain's message of "Sat, 16 Nov 2019 14:36:57 +1100")
Message-ID: <yq1sgmkiic7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190043
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Finn,

> Add a module parameter to inhibit disconnect/reselect for individual
> targets. This gains compatibility with Aztec PowerMonster SCSI/SATA
> adapters with buggy firmware. (No fix is available from the vendor.)

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

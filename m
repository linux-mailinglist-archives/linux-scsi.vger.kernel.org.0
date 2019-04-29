Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352A3E1C5
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfD2MCM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 08:02:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MCM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 08:02:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBxJCN196386;
        Mon, 29 Apr 2019 12:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Ucrdw9LrlFpEm1QgPZwhzeFln0y3zBwLgw8brzv6wqU=;
 b=0X52wFHISeu1GGT9kGvkX3Uu3E/svc9PUwoo9/XTb04b2JoFU7jrDDiTNi2MVA7Pakf2
 KcRnrQbkQ6sERr1Nbi2IizgoJ8wxOrxqQ/VvwBZACxfcVzJe6uCRpZVPyh1ZvegZBCg4
 4OsspX7JGdIHFkbdUzgwYq6wtLX7/AGDFvGvAoMeh05U7lT/Wwna1cCSeXP56TLii0Zs
 HNin+j2nWO1DIIU2ATpwTUErMaapnXjKH1aVdnIfHdtqS58DjCIuU73DT/vWvm2Myr2Z
 5SeNEz64vXEJOw/V53yCoIbuoZ/BUntIU1cDEiZK4bfQ967UE5OV2+UI0xyzXQmhQq1M nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s4fqpwtc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:02:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBwdIi124616;
        Mon, 29 Apr 2019 12:00:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s4d49wc7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:00:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TC05OX025772;
        Mon, 29 Apr 2019 12:00:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:00:05 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic7xxx: improve the Kconfig entry
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190422173509.13602-1-hch@lst.de>
Date:   Mon, 29 Apr 2019 08:00:02 -0400
In-Reply-To: <20190422173509.13602-1-hch@lst.de> (Christoph Hellwig's message
        of "Mon, 22 Apr 2019 19:35:09 +0200")
Message-ID: <yq1r29l10ot.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=589
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290087
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=625 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290088
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Christoph,

> There is no old vs new driver anymore.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

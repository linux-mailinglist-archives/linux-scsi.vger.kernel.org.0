Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019181012A2
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Nov 2019 05:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKSEpP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Nov 2019 23:45:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSEpP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Nov 2019 23:45:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4hhOX077926;
        Tue, 19 Nov 2019 04:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=P4T/RLDFvJ6qN2Upx5OjPezOF8dhMaemsOxf3TvuhPA=;
 b=qemxDWm3kRD/JDCjIc5A9ANgWjO1V1RjB925J5trWKfuKX6zGu+s9b+xCqU5FDbq8pkb
 ViDcZTgranHhbycHozFYNKIMy49wuSZ4J98b1v5EMeqT1eTF3v+NRJMYT7XyBmwVGQSC
 HImP1ktnxRtnzFyvRgLtIeADr1mCYfhe1fTO4PMi21WyRePbGeAUeRMHWqkF41ls8pxd
 /ITTC/qiXvLytuf7LtGahRerzfsIkswZxMwhddjcqpcJ5VHjD2zjRgwI+zXVSOY3Rqg6
 ZDzqfNI3YjieNoqBko1Q22dRMTAy/3TG50efPqJNaZJFNVaIgUh88tEBGGyFxTTKk2/y zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqcb1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 04:45:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ4gXfD096995;
        Tue, 19 Nov 2019 04:45:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wbxgdy50a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 04:45:08 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ4j6Cf028121;
        Tue, 19 Nov 2019 04:45:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 20:45:05 -0800
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Ondrej Zary" <linux@zary.sk>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NCR5380: Unconditionally clear ICR after do_abort()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <4277b28ee2551f884aefa85965ef3c498344f301.1573875417.git.fthain@telegraphics.com.au>
Date:   Mon, 18 Nov 2019 23:45:03 -0500
In-Reply-To: <4277b28ee2551f884aefa85965ef3c498344f301.1573875417.git.fthain@telegraphics.com.au>
        (Finn Thain's message of "Sat, 16 Nov 2019 14:36:57 +1100")
Message-ID: <yq1wobwiieo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=653
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=724 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190042
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Finn,

> When do_abort() succeeds, the target will go to BUS FREE phase and
> there will be no connected command. Therefore, that function should
> clear the Initiator Command Register before returning. It already does
> so in case of NCR5380_poll_politely() failure; do the same for the
> other error case too, that is, NCR5380_transfer_pio() failure.

Applied to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

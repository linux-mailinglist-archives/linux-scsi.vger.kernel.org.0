Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26714AE7F
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Jan 2020 04:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgA1DxT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Jan 2020 22:53:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA1DxT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Jan 2020 22:53:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S3nPWn189328;
        Tue, 28 Jan 2020 03:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=c8hLTfMJVQ9vXG1IKcohNpda9SWBPyWk9ElNYuGSm9o=;
 b=AFgyI287qYR6g6x7g0gWo9kIhYKAdNUMDcGJlvdbEIN0g4ENvG9QlvusFF1pcH2PJwGK
 gKKsuijZSC2mwCWGviWRCK/3TC7NHe+fNLuFABnobWVs07RaBE2nBptNQMAw2wVxZ95m
 h875YhW15c6QhVeI8o5U/ae9sNTDTIFHqFYn5wVSEHB102XbgGmXc1Qhp1bPg+2Ocg11
 uDSIowU3Z4yXZvkNn1aiq3IKpJiQmy3L7SqxmxGOGF5Q4uD4cgUVjR/qSFBYol9UzkA4
 j2FdVKlApe3S100rzoJQaQB2CyNa6XfPWOaSF2BTb/9JFLzlEJSjP+7mGmwuu2w6n1zQ LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xrear3arp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 03:53:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00S3nENA124392;
        Tue, 28 Jan 2020 03:51:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xta8gs6fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 03:51:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00S3pBPB005115;
        Tue, 28 Jan 2020 03:51:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 19:51:11 -0800
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pm80xx: fix spelling mistake "to" -> "too"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200123005706.2834281-1-colin.king@canonical.com>
Date:   Mon, 27 Jan 2020 22:51:09 -0500
In-Reply-To: <20200123005706.2834281-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 23 Jan 2020 00:57:06 +0000")
Message-ID: <yq1zhe89r2q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=865 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280029
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Colin,

> There is a spelling mistake in a pm8001_printk message. Fix it.

Applied to 5.6/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

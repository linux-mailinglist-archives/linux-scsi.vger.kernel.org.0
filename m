Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997EF4AF72
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 03:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFSBVg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 21:21:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43582 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFSBVg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 21:21:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J14gVq192813;
        Wed, 19 Jun 2019 01:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MMQvbBgyvP8fRxmHsb8Us7gkwLCMMcE5Oq2smVIAGBQ=;
 b=5Yhu8ZL5FsufrfyFGUPaz/+/qN2s/CoIBPdRt569RSO1OGHh2heamF6g5H8ou3N2DLHb
 G/OZlcXJEXWMgVcWCfj+V94LIIhMm3jljFEBPCOoMyYVEIzDAhdGteugdH9dkgHFbB1V
 BZd/NtEw+VKklOYsEwh7F1uETe2oKB8CiyHjeWhAXmHeR+36L/3Ut0xO5tXbblTIWaBy
 e1O23aDzy6mscm2Pm+G0/1VwIl2Pllb37PrWLTh0k/7cm5niBmns5zv8oQ04cRsM2xDX
 GH7YCZalDiMGDv4RMAa9/rddDu3z8q8t3DFbEXrbdstbhlrJdUXRaFLk6QlZj58PQL2v cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t78098gv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:21:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J1LC6i075148;
        Wed, 19 Jun 2019 01:21:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t77yn23at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:21:20 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J1LI0a020768;
        Wed, 19 Jun 2019 01:21:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:21:18 -0700
To:     Varun Prakash <varun@chelsio.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        dt@chelsio.com, indranil@chelsio.com, ganji.aravind@chelsio.com
Subject: Re: [PATCH] scsi: cxgb4i: add support for IEEE_8021QAZ_APP_SEL_STREAM selector
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560777386-5295-1-git-send-email-varun@chelsio.com>
Date:   Tue, 18 Jun 2019 21:21:16 -0400
In-Reply-To: <1560777386-5295-1-git-send-email-varun@chelsio.com> (Varun
        Prakash's message of "Mon, 17 Jun 2019 18:46:26 +0530")
Message-ID: <yq17e9ixtdf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190007
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Varun,

> IEEE_8021QAZ_APP_SEL_STREAM is a valid selector for iSCSI connections,
> so add code to use IEEE_8021QAZ_APP_SEL_STREAM selector to get
> priority mask.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

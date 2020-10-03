Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643AE282056
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Oct 2020 04:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJCCG3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Oct 2020 22:06:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJCCG2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Oct 2020 22:06:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09320A31097895;
        Sat, 3 Oct 2020 02:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=1QmBuVxU8/7aUUHR7eRreXsdSrts8/ZOsqlb3it2bzo=;
 b=nep0IxwCZNhJ/nHOf3oUC5C423tnmsoOxZiixQbW52X4ec0I1HsPeNFh4v+D8ICSsmhI
 eDTw4r2J3NjrmjLgTdZ68kLi9Nnbebr7HnNW9jK6h8DAhDWkP3gHiZPeLlYemvypDnJ/
 yeb7CZcPsZmHQ8j18eksaCjfjtE0UZMt7OodlJ0Cgi5/2fSOda/5BCVzQAsEvzqe8wqe
 3mFUkNOWHX0z9Yt+nSJFnDcR6J2pXbr6G2WwrgpxEvMbPGgymIzwvsJ1c2MIZ/NmNJgq
 sbGfu5IB9Ulc1CJWLya3YmVVxMeIwJ+zLkCCDgJZ5CNtWsuH3bbmqimWAZoXwH94cdAQ FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33swkmdh3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 03 Oct 2020 02:06:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 093211Nm058463;
        Sat, 3 Oct 2020 02:04:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33xfb8gunt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Oct 2020 02:04:15 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09324EIT012241;
        Sat, 3 Oct 2020 02:04:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 19:04:14 -0700
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: snic: convert to use DEFINE_SEQ_ATTRIBUTE
 macro
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2koawve.fsf@ca-mkp.ca.oracle.com>
References: <20200916025030.3992991-1-liushixin2@huawei.com>
Date:   Fri, 02 Oct 2020 22:04:11 -0400
In-Reply-To: <20200916025030.3992991-1-liushixin2@huawei.com> (Liu Shixin's
        message of "Wed, 16 Sep 2020 10:50:30 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010030018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010030018
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Liu,

> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

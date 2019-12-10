Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C38117CA5
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Dec 2019 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfLJArm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Dec 2019 19:47:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54992 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfLJArk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Dec 2019 19:47:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA0i6fT058455;
        Tue, 10 Dec 2019 00:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=izeoPvaK2NeEzbuStKxG3HkhC5QTua84SwKN4/w9x2U=;
 b=UpD8Hjf9B7ykmx45FWUDvMkby38QY00Sq5oD/pTVzwz2qK8gv21gjxWvefcp85bhdcFo
 UJjQnpdlm7v1nyUXtHj4fRW8BU6fmfHulNOJc1oi5gqgcbIl02ALfdF9z7Yl6/uvWOwn
 jQ+ETvQwnXbs4b2RKloCu+HAfPhXgYhgcKmrs6xw/woe2CBZsxqz09HhCNS9pRjecepY
 4mQCpCzSVzKTkQk8XnejWwb9K2Wt9FA8th90FbjoLX66nN1FaXU2sEQ2vm2mNpB84bn8
 10Xd1b9WN5LuMieEkTsHrq0Ey/npv82czlVwiALV1BYXjKRo7BrbzmaG5+ZPjzSpF2PK Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wr41q30y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 00:47:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBA0i0jd054000;
        Tue, 10 Dec 2019 00:47:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wsv8auxtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 00:47:35 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBA0lXpX014996;
        Tue, 10 Dec 2019 00:47:34 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Dec 2019 16:47:33 -0800
To:     Can Guo <cang@codeaurora.org>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com
Subject: Re: [PATCH v6 0/5] UFS driver general fixes bundle 1
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <0101016ed3d62f70-fd63eb46-fab2-4d40-afc8-25a5faefe5cd-000000@us-west-2.amazonses.com>
Date:   Mon, 09 Dec 2019 19:47:31 -0500
In-Reply-To: <0101016ed3d62f70-fd63eb46-fab2-4d40-afc8-25a5faefe5cd-000000@us-west-2.amazonses.com>
        (Can Guo's message of "Thu, 5 Dec 2019 02:14:19 +0000")
Message-ID: <yq1lfrlnh0c.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912100005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9466 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912100005
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Can,

> This bundle includes 5 general fixes for UFS driver.

Applied to 5.6/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

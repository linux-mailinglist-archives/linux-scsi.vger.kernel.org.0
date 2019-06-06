Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A338072
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfFFWUk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 18:20:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48926 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFFWUk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 18:20:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56MIotd092824;
        Thu, 6 Jun 2019 22:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=FW9wPepx12cNl753Ed0uG7Zzzkt8j8w9pmI2iR/xN+s=;
 b=hVO99Xda8lrwOije4RyMkQGDsD6axGisskg+HTR5yRYX7RpX+7rfHc69Gn1whbFp8/ia
 uIN98RTLYlwc3AiVKzr4hnXQSTSfijlabVrbN0EPPJlWkCsTl1thySXbj0v2LWYeeWor
 uxbtCgNcGMZ0MzdMCWDCdQ2JRx9PkwhmSh4JMxASf7KXzeQyBWlnsVLy+k8wLki2fr/R
 +8zZ1XWq82sYYEyOfW4jgf5hw9gL4Fy2kcIgadSlq5t1FYcJSKsEfgy/Yb1bs5TE7XiN
 1ullpubr3PUhDINCib4nH/tcZEj3k/6RLU1vjXdO3mhX2OXgo2gJHj1j4i4d6ABJxPsK 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sugstu6gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 22:19:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56MJ50a006143;
        Thu, 6 Jun 2019 22:19:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngmrxe5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 22:19:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56MJG7D020788;
        Thu, 6 Jun 2019 22:19:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 15:19:16 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 0/3] scsi: three SG_CHAIN related fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190606083410.32243-1-ming.lei@redhat.com>
Date:   Thu, 06 Jun 2019 18:19:13 -0400
In-Reply-To: <20190606083410.32243-1-ming.lei@redhat.com> (Ming Lei's message
        of "Thu, 6 Jun 2019 16:34:07 +0800")
Message-ID: <yq1ftommk66.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=843 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060151
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> Guenter reported scsi boot issue caused by commit c3288dd8c232 ("scsi:
> core: avoid pre-allocating big SGL for data").

Applied to 5.3/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering

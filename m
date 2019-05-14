Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE271E422
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 23:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfENVue (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 17:50:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52876 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENVue (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 17:50:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ELhedX183297;
        Tue, 14 May 2019 21:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=mt/YcEfIhP0V34MfF7iEOOjMUhQg6grPeP/C0brtVjA=;
 b=JPcZCVlzjQVpvVfSddNFr1eGaZ5E0OX5atAxn3RyFXDYQyaLJuGej47CX4TfSmyC0hSJ
 7x95195cjOkbfZswEd4I5TEpfRpunZ38tGJAGrj8E9ZeQA+UfGS/tx0XP8o52tS1l/PZ
 nSmP7/dFM3BSg+uozMoh7eLc9Xa68muxlMZP1MXci6Tlm0vkcHFa5qtEfVhOL5saH1zT
 1CXY591+Ojwi7cI3BlB9jNF/61wSQrUkSLfxKlv6yhVkMJlkZzKJRcURKdljtkKnWcN/
 /0YZ+Mr6d9HPdzTh4cZ+K7QF2O/vGRDvPBwPHpFiSPy/itjO6TQcLz+V6XuJDCV+hcKh kA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sdq1qgxr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 21:50:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4ELnkkJ138041;
        Tue, 14 May 2019 21:50:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sdnqjuaur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 21:50:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4ELoUcv025719;
        Tue, 14 May 2019 21:50:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 14:50:30 -0700
To:     Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, kiran-kumar.kasturi@broadcom.com,
        sankar.patra@broadcom.com, sasikumar.pc@broadcom.com
Subject: Re: [PATCH v2 00/21] megaraid_sas: Driver updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Date:   Tue, 14 May 2019 17:50:27 -0400
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
        (Shivasharan S.'s message of "Tue, 7 May 2019 10:05:29 -0700")
Message-ID: <yq1ef50d7to.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=658
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140143
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=707 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140143
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Shivasharan,

> Update megaraid_sas to version 07.708.03.00.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

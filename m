Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C80288FD9
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Oct 2020 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgJIROw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Oct 2020 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbgJIROu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Oct 2020 13:14:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB29C0613D2
        for <linux-scsi@vger.kernel.org>; Fri,  9 Oct 2020 10:14:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 132so816467pfz.5
        for <linux-scsi@vger.kernel.org>; Fri, 09 Oct 2020 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=fsLcsh2OqZjEGlzU6yFMYJb/QM7fX7UOgYfaY4ekFXg=;
        b=ccfFBVTxfLw5i/7R6atdeEpxbSAM/WrxlSmYewGLjbZ5/rc1hdprjbzKq0mGlHyuYm
         Re2JEQMMhR4lEZevFKZgWCX+sw+1QCfnu4xLQxKCeRrb9tY/m5kBzl/yuIN1RzUgyDto
         nFwGI2qzXsISBqinr93CqKvX3+49+9dRBGNL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=fsLcsh2OqZjEGlzU6yFMYJb/QM7fX7UOgYfaY4ekFXg=;
        b=p31SOKqzbrWPtjk0OeqJspMEpY7Qdkcy0qwQHIu7IXPPGrBW6Sng26Eh9uxrD7GLUp
         H6nfxKXJLm838qmlokmtVzZmPp0eC1JUKQBvQY9RkiTUNIy+wD5B73tuodaEJ/plHo1m
         25eJTZNztyhr2+wANWD8l00a0f4p71pi78vFdK5s5N66rmI8z02imoJrq8VMwNLLPCwn
         Kk0cgyNS8j7YKTmwc9pCSPylGDKjQxw58T3OlsqOKzHsC5eu6WWcvrDnVU65sm/RHIBa
         1Ja3K2mksi2GZFrp7VBU14MO0RTIM6QGq6GzQcPqqThwj57u7SbcR+BAbzYyF51Bvn2W
         0biA==
X-Gm-Message-State: AOAM533tDWUNOQANHgwi2NY8EXffZaixeJlvorzYZ30S2/Hmd3RPe6FN
        vIDnCRNltR2R2yKfVjYpXG+5fQ==
X-Google-Smtp-Source: ABdhPJzrN7jbGix/7tBy1RFGr1RcT29nuXyZlwKgcFm7hDqqw1Db3PEIjdNxHyQGUixQI1IMT4slXg==
X-Received: by 2002:a63:5566:: with SMTP id f38mr4363335pgm.9.1602263689364;
        Fri, 09 Oct 2020 10:14:49 -0700 (PDT)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id fy24sm12299055pjb.35.2020.10.09.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:14:48 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 12/14] mpt3sas: Handle vSES vphy object during HBA reset
Date:   Fri,  9 Oct 2020 22:44:38 +0530
Message-Id: <20201009171440.4949-13-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
References: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000013cc3605b1401674"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000013cc3605b1401674
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During HBA reset, Port ID of vSES device may change.
So, need to refresh virtual_phy objects after reset.

Each Port’s vphy_list table needs to be updated after updating the
HBA port table. Follow the below algorithm to update each
Port’s vphy_list table.
• Loop over each port entry from HBA port table
  * Loop over each virtual phy entry from port’s vphys_list table
    - Mark virtual phy entry as dirty by setting dirty bit in virtual phy
      entry’s flags field
• Read SASIOUnitPage0 page
• Loop over each HBA Phy’s Phy data from SASIOUnitPage0
  * If phy’s remote attached device is not SES device then continue with
    processing next HBA Phy’s Phy data,
  * Read SASPhyPage0 data for this Phy number and determine whether
    current phy is a virtual phy or not. If it is not a virtual phy
    then continue with next Phy data,
  * Get the current phy’s remote attached vSES device’s SAS Address,
  * Loop over each port entry from HBA port table
    - If Port’s vphys_mask field is zero then continue with
      next Port entry,
    - Loop over each virtual phy entry from Port’s vphy_list table
      • If the current phy’s remote SAS Address is different from
        virtual phy entry’s SAS Address then continue with next
        virtual phy entry,
      • Set bit corresponding to current phy number in virtual phy
        entry’s of phy_mask field,
      • Get the HBA port table’s Port entry corresponding to
        Phy data’s ‘Port’ value,
	* If there is no Port entry corresponding to Phy data’s ‘Port’
	  value in HBA port table then create a new port entry and
          add it to HBA port table.
      • If this retrieved Port entry is the same as the current Port
        entry then don’t do anything, just clear the dirty bit from
        virtual phy entry’s flag field and continue with processing
        next HBA Phy’s Phy data.
      • If this retrieved Port entry is different from the current Port
        entry then move the current virtual phy entry from current Port’s
        vphys_list to retrieved Port entry’s vphys_list.
        * Clear current phy bit in current Port entry’s vphys_mask and
          set the current phy bit in the retrieved Port entry’s
          vphys_mask field.
        * Clear the dirty bit from virtual phy entry’s flag field and
          continue with next HBA Phy’s Phy data.
• Delete the ‘virtual phy’ entries and HBA’s ‘Port table’
  entries which are still marked as ‘dirty’.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 233 +++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 522e4d0..da4ffa6 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -5847,6 +5847,204 @@ _scsih_io_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index, u32 reply)
 	return 0;
 }
 
+/**
+ * _scsih_update_vphys_after_reset - update the Port's
+ *			vphys_list after reset
+ * @ioc: per adapter object
+ *
+ * Returns nothing.
+ */
+static void
+_scsih_update_vphys_after_reset(struct MPT3SAS_ADAPTER *ioc)
+{
+	u16 sz, ioc_status;
+	int i;
+	Mpi2ConfigReply_t mpi_reply;
+	Mpi2SasIOUnitPage0_t *sas_iounit_pg0 = NULL;
+	u16 attached_handle;
+	u64 attached_sas_addr;
+	u8 found = 0, port_id;
+	Mpi2SasPhyPage0_t phy_pg0;
+	struct hba_port *port, *port_next, *mport;
+	struct virtual_phy *vphy, *vphy_next;
+	struct _sas_device *sas_device;
+
+	/*
+	 * Mark all the vphys objects as dirty.
+	 */
+	list_for_each_entry_safe(port, port_next,
+	    &ioc->port_table_list, list) {
+		if (!port->vphys_mask)
+			continue;
+		list_for_each_entry_safe(vphy, vphy_next,
+		    &port->vphys_list, list) {
+			vphy->flags |= MPT_VPHY_FLAG_DIRTY_PHY;
+		}
+	}
+
+	/*
+	 * Read SASIOUnitPage0 to get each HBA Phy's data.
+	 */
+	sz = offsetof(Mpi2SasIOUnitPage0_t, PhyData) +
+	    (ioc->sas_hba.num_phys * sizeof(Mpi2SasIOUnit0PhyData_t));
+	sas_iounit_pg0 = kzalloc(sz, GFP_KERNEL);
+	if (!sas_iounit_pg0) {
+		ioc_err(ioc, "failure at %s:%d/%s()!\n",
+		    __FILE__, __LINE__, __func__);
+		return;
+	}
+	if ((mpt3sas_config_get_sas_iounit_pg0(ioc, &mpi_reply,
+	    sas_iounit_pg0, sz)) != 0)
+		goto out;
+	ioc_status = le16_to_cpu(mpi_reply.IOCStatus) & MPI2_IOCSTATUS_MASK;
+	if (ioc_status != MPI2_IOCSTATUS_SUCCESS)
+		goto out;
+	/*
+	 * Loop over each HBA Phy.
+	 */
+	for (i = 0; i < ioc->sas_hba.num_phys; i++) {
+		/*
+		 * Check whether Phy's Negotiation Link Rate is > 1.5G or not.
+		 */
+		if ((sas_iounit_pg0->PhyData[i].NegotiatedLinkRate >> 4) <
+		    MPI2_SAS_NEG_LINK_RATE_1_5)
+			continue;
+		/*
+		 * Check whether Phy is connected to SEP device or not,
+		 * if it is SEP device then read the Phy's SASPHYPage0 data to
+		 * determine whether Phy is a virtual Phy or not. if it is
+		 * virtual phy then it is conformed that the attached remote
+		 * device is a HBA's vSES device.
+		 */
+		if (!(le32_to_cpu(
+		    sas_iounit_pg0->PhyData[i].ControllerPhyDeviceInfo) &
+		    MPI2_SAS_DEVICE_INFO_SEP))
+			continue;
+
+		if ((mpt3sas_config_get_phy_pg0(ioc, &mpi_reply, &phy_pg0,
+		    i))) {
+			ioc_err(ioc, "failure at %s:%d/%s()!\n",
+			    __FILE__, __LINE__, __func__);
+			continue;
+		}
+
+		if (!(le32_to_cpu(phy_pg0.PhyInfo) &
+		    MPI2_SAS_PHYINFO_VIRTUAL_PHY))
+			continue;
+		/*
+		 * Get the vSES device's SAS Address.
+		 */
+		attached_handle = le16_to_cpu(
+		    sas_iounit_pg0->PhyData[i].AttachedDevHandle);
+		if (_scsih_get_sas_address(ioc, attached_handle,
+		    &attached_sas_addr) != 0) {
+			ioc_err(ioc, "failure at %s:%d/%s()!\n",
+			    __FILE__, __LINE__, __func__);
+			continue;
+		}
+
+		found = 0;
+		port = port_next = NULL;
+		/*
+		 * Loop over each virtual_phy object from
+		 * each port's vphys_list.
+		 */
+		list_for_each_entry_safe(port,
+		    port_next, &ioc->port_table_list, list) {
+			if (!port->vphys_mask)
+				continue;
+			list_for_each_entry_safe(vphy, vphy_next,
+			    &port->vphys_list, list) {
+				/*
+				 * Continue with next virtual_phy object
+				 * if the object is not marked as dirty.
+				 */
+				if (!(vphy->flags & MPT_VPHY_FLAG_DIRTY_PHY))
+					continue;
+
+				/*
+				 * Continue with next virtual_phy object
+				 * if the object's SAS Address is not equals
+				 * to current Phy's vSES device SAS Address.
+				 */
+				if (vphy->sas_address != attached_sas_addr)
+					continue;
+				/*
+				 * Enable current Phy number bit in object's
+				 * phy_mask field.
+				 */
+				if (!(vphy->phy_mask & (1 << i)))
+					vphy->phy_mask = (1 << i);
+				/*
+				 * Get hba_port object from hba_port table
+				 * corresponding to current phy's Port ID.
+				 * if there is no hba_port object corresponding
+				 * to Phy's Port ID then create a new hba_port
+				 * object & add to hba_port table.
+				 */
+				port_id = sas_iounit_pg0->PhyData[i].Port;
+				mport = mpt3sas_get_port_by_id(ioc, port_id, 1);
+				if (!mport) {
+					mport = kzalloc(
+					    sizeof(struct hba_port), GFP_KERNEL);
+					if (!mport)
+						break;
+					mport->port_id = port_id;
+					ioc_info(ioc,
+					    "%s: hba_port entry: %p, port: %d is added to hba_port list\n",
+					    __func__, mport, mport->port_id);
+					list_add_tail(&mport->list,
+						&ioc->port_table_list);
+				}
+				/*
+				 * If mport & port pointers are not pointing to
+				 * same hba_port object then it means that vSES
+				 * device's Port ID got changed after reset and
+				 * hence move current virtual_phy object from
+				 * port's vphys_list to mport's vphys_list.
+				 */
+				if (port != mport) {
+					if (!mport->vphys_mask)
+						INIT_LIST_HEAD(
+						    &mport->vphys_list);
+					mport->vphys_mask |= (1 << i);
+					port->vphys_mask &= ~(1 << i);
+					list_move(&vphy->list,
+					    &mport->vphys_list);
+					sas_device = mpt3sas_get_sdev_by_addr(
+					    ioc, attached_sas_addr, port);
+					if (sas_device)
+						sas_device->port = mport;
+				}
+				/*
+				 * Earlier while updating the hba_port table,
+				 * it is determined that there is no other
+				 * direct attached device with mport's Port ID,
+				 * Hence mport was marked as dirty. Only vSES
+				 * device has this Port ID, so unmark the mport
+				 * as dirt.
+				 */
+				if (mport->flags & HBA_PORT_FLAG_DIRTY_PORT) {
+					mport->sas_address = 0;
+					mport->phy_mask = 0;
+					mport->flags &=
+					    ~HBA_PORT_FLAG_DIRTY_PORT;
+				}
+				/*
+				 * Unmark current virtual_phy object as dirty.
+				 */
+				vphy->flags &= ~MPT_VPHY_FLAG_DIRTY_PHY;
+				found = 1;
+				break;
+			}
+			if (found)
+				break;
+		}
+	}
+out:
+	kfree(sas_iounit_pg0);
+}
+
 /**
  * _scsih_get_port_table_after_reset - Construct temporary port table
  * @ioc: per adapter object
@@ -6066,6 +6264,39 @@ _scsih_add_or_del_phys_from_existing_port(struct MPT3SAS_ADAPTER *ioc,
 	}
 }
 
+/**
+ * _scsih_del_dirty_vphy - delete virtual_phy objects marked as dirty.
+ * @ioc: per adapter object
+ *
+ * Returns nothing.
+ */
+static void
+_scsih_del_dirty_vphy(struct MPT3SAS_ADAPTER *ioc)
+{
+	struct hba_port *port, *port_next;
+	struct virtual_phy *vphy, *vphy_next;
+
+	list_for_each_entry_safe(port, port_next,
+	    &ioc->port_table_list, list) {
+		if (!port->vphys_mask)
+			continue;
+		list_for_each_entry_safe(vphy, vphy_next,
+		    &port->vphys_list, list) {
+			if (vphy->flags & MPT_VPHY_FLAG_DIRTY_PHY) {
+				drsprintk(ioc, ioc_info(ioc,
+				    "Deleting vphy %p entry from port id: %d\t, Phy_mask 0x%08x\n",
+				    vphy, port->port_id,
+				    vphy->phy_mask));
+				port->vphys_mask &= ~vphy->phy_mask;
+				list_del(&vphy->list);
+				kfree(vphy);
+			}
+		}
+		if (!port->vphys_mask && !port->sas_address)
+			port->flags |= HBA_PORT_FLAG_DIRTY_PORT;
+	}
+}
+
 /**
  * _scsih_del_dirty_port_entries - delete dirty port entries from port list
  *					after host reset
@@ -10246,6 +10477,7 @@ mpt3sas_scsih_reset_done_handler(struct MPT3SAS_ADAPTER *ioc)
 	if ((!ioc->is_driver_loading) && !(disable_discovery > 0 &&
 					   !ioc->sas_hba.num_phys)) {
 		_scsih_sas_port_refresh(ioc);
+		_scsih_update_vphys_after_reset(ioc);
 		_scsih_prep_device_scan(ioc);
 		_scsih_create_enclosure_list_after_reset(ioc);
 		_scsih_search_responding_sas_devices(ioc);
@@ -10293,6 +10525,7 @@ _mpt3sas_fw_work(struct MPT3SAS_ADAPTER *ioc, struct fw_event_work *fw_event)
 			ssleep(1);
 		}
 		_scsih_remove_unresponding_devices(ioc);
+		_scsih_del_dirty_vphy(ioc);
 		_scsih_del_dirty_port_entries(ioc);
 		_scsih_scan_for_devices_after_reset(ioc);
 		_scsih_set_nvme_max_shutdown_latency(ioc);
-- 
2.18.4


--00000000000013cc3605b1401674
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Rag/s/0IKyxAQsoBcla5ZufuDE5ir/mlnYktkPJdg+kns/OPDsINSyWqNYE9PKy9+3cp/fItNFtH
krg1AgMBAAGjggHTMIIBzzAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsG
AQUFBzAChkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2ln
bjJzaGEyZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29t
L2dzcGVyc29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEF
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBE
BgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWdu
MnNoYTJnMy5jcmwwJwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4E
FgQU1CyhXqcQo40SZ7kFS/AiOnRW6lMwDQYJKoZIhvcNAQELBQADggEBAFeMmmz112eNFAV8Ense
5WremClV5F3Md1xS0yXKqxlgakUJaOI/Fai7OLQaQqsEoxW6/QqWEi1wbZOccbdritOkL5b7sVUp
SU9OfuIlV8c3XMLaWSIluy+0ImtRJ49jDCI4KtQESHrqfQRZcc1C/avZvNED3U4b10U6N3SY+59b
fm2Vlwacwp+8ESTp49DsLcJqc4U/0rUZxLWtgPokzS+ovX+JAu8zx1SmOzUC4hj4Bp6Vnfd5KWUK
JJQBmQHXii+acSeTgHmPWUYs3tYQ0uIX0Yy8LUWPdGbEq+KWepzY2otC+iVWdngCCv8Nf1Xo1jki
AGJ6hrlWFE0qJVWv25sxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hB
MjU2IC0gRzMCDBmG1a14/wFg8qBhUjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
5GM3bNDY4TusVMuIirfPyhBOF3UYIdtlFG3trX2PCKowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjAxMDA5MTcxNDQ5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEPliOH6XZSXjb0z7pIw
cQjQgMRAD6VJ5rf+Gwdl5kiwyIakQxjSoXyEZ7vSL2UbR9YLT+WTIHIgHRMHeG6dx8U2if9Qb5J0
IwlKqNewM4e5gr6tnPfc8WjSUUozBxRysglDcsNyUoTD3bpPMh9tjkWoEPjxHt92YpH5ZXTE5EL2
7tl7hNWd9lbpD5pnWdjrRPHJiFDDeG7h9YUKNnYfZaOxtcf0qncaPMe2lEoZ+I19wZOIgs0X0S9i
piN6DEeVQLjL6DJl1mJKKtBf9vj3zQ4sMzWfwLr0RRw9bwdniTn461tFDHe3bDmKgm2FnYRf8uR+
PbiDP4wQbCzMXv1ThsE=
--00000000000013cc3605b1401674--
